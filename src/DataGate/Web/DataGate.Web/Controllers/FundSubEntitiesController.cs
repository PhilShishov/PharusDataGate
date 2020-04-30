﻿namespace DataGate.Web.Controllers
{
    using System;
    using System.Globalization;
    using System.IO;
    using System.Linq;

    using DataGate.Common;
    using DataGate.Services.Data.Files;
    using DataGate.Services.Data.FundSubFunds.Contracts;
    using DataGate.Web.Utilities;
    using DataGate.Web.ViewModels.Entities;

    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.Mvc;

    [Authorize]
    public class FundSubEntitiesController : BaseController
    {
        private readonly IFundSubFundsService fundsService;
        private readonly IFileSystemService entitiesFileService;
        private readonly IWebHostEnvironment environment;

        public FundSubEntitiesController(
                    IFundSubFundsService fundSubFundsService,
                    IFileSystemService entitiesFileService,
                    IWebHostEnvironment environment)
        {
            this.fundsService = fundSubFundsService;
            this.entitiesFileService = entitiesFileService;
            this.environment = environment;
        }

        [HttpGet]
        [Route("f/{EntityId}/{ChosenDate}")]
        public IActionResult ByIdAndDate(int entityId, string chosenDate)
        {
            SpecificEntityViewModel viewModel = new SpecificEntityViewModel
            {
                ChosenDate = chosenDate,
                EntityId = entityId,
            };

            this.SetModelValuesForSpecificView(viewModel);

            this.ModelState.Clear();
            return this.View(viewModel);
        }

        public JsonResult AutoCompleteSubFundList(string selectTerm, int entityId)
        {
            var entitiesToSearch = this.fundsService
                .GetFund_SubFunds(null, entityId)
                .Skip(1)
                .ToList();

            if (selectTerm != null)
            {
                entitiesToSearch = entitiesToSearch
                    .Where(sf => sf[GlobalConstants.IndexEntityNameInSQLTable]
                        .ToLower()
                        .Contains(selectTerm
                        .ToLower()))
                    .ToList();
            }

            var modifiedData = entitiesToSearch.Select(sf => new
            {
                id = sf[GlobalConstants.IndexEntityNameInSQLTable],
                text = sf[GlobalConstants.IndexEntityNameInSQLTable],
            });

            return this.Json(modifiedData);
        }

        [HttpPost]
        public IActionResult ByIdAndDate(SpecificEntityViewModel model)
        {
            this.SetModelValuesForSpecificView(model);

            if (model.Command == "Update Table")
            {
                return this.RedirectToAction(GlobalConstants.ByIdAndDateActionName, new { model.EntityId, model.ChosenDate });
            }

            if (model.Command == "Reset")
            {
                model.SelectTerm = GlobalConstants.DefaultAutocompleteSelectTerm;
                return this.View(model);
            }

            bool isInSelectionMode = false;

            if (model.SelectedColumns != null && model.SelectedColumns.Count > 0)
            {
                isInSelectionMode = true;
            }

            var chosenDate = DateTime.ParseExact(model.ChosenDate, GlobalConstants.RequiredWebDateTimeFormat, CultureInfo.InvariantCulture);

            if (model.SelectTerm == null)
            {
                if (isInSelectionMode)
                {
                    this.CallEntitySubEntitiesWithSelectedColumns(model, chosenDate);
                }
                else if (!isInSelectionMode)
                {
                    model.EntitySubEntities = this.fundsService.GetFund_SubFunds(chosenDate, model.EntityId).ToList();
                }

                return this.View(model);
            }

            if (isInSelectionMode)
            {
                this.CallEntitySubEntitiesWithSelectedColumns(model, chosenDate);
            }
            else if (!isInSelectionMode)
            {
                model.EntitySubEntities = this.fundsService
                    .GetFund_SubFunds(chosenDate, model.EntityId)
                    .ToList();
            }

            if (model.SelectTerm != null)
            {
                model.EntitySubEntities = CreateTableView.AddTableToView(model.EntitySubEntities, model.SelectTerm.ToLower());
            }

            if (model.Entity != null && model.EntitySubEntities != null)
            {
                return this.View(model);
            }

            this.ModelState.Clear();
            return this.View();
        }

        [HttpPost]
        public IActionResult UploadProspectus(SpecificEntityViewModel model)
        {
            this.SetModelValuesForSpecificView(model);

            var file = model.UploadEntityFileModel.FileToUpload;

            if (file != null || file.FileName != string.Empty)
            {
                //                private string[] permittedExtensions = { ".txt", ".pdf" };

                //        var ext = Path.GetExtension(uploadedFileName).ToLowerInvariant();

                //if (string.IsNullOrEmpty(ext) || !permittedExtensions.Contains(ext))
                //{
                //    // The extension is invalid ... discontinue processing the file
                //}

                //                private static readonly Dictionary<string, List<byte[]>> _fileSignature =
                //    new Dictionary<string, List<byte[]>>
                //{
                //    { ".jpeg", new List<byte[]>
                //        {
                //            new byte[] { 0xFF, 0xD8, 0xFF, 0xE0 },
                //            new byte[] { 0xFF, 0xD8, 0xFF, 0xE2 },
                //            new byte[] { 0xFF, 0xD8, 0xFF, 0xE3 },
                //        }
                //    },
                //};

                //using (var reader = new BinaryReader(uploadedFileData))
                //{
                //    var signatures = _fileSignature[ext];
                //    var headerBytes = reader.ReadBytes(signatures.Max(m => m.Length));

                //    return signatures.Any(signature => 
                //        headerBytes.Take(signature.Length).SequenceEqual(signature));
                //}

                //                Size validation
                //Limit the size of uploaded files.

                //In the sample app, the size of the file is limited to 2 MB(indicated in bytes).The limit is supplied via Configuration from the appsettings.json file:

                //JSON

                //Copy
                //{
                //                    "FileSizeLimit": 2097152
                //}
                //                The FileSizeLimit is injected into PageModel classes:

                //C#

                //Copy
                //public class BufferedSingleFileUploadPhysicalModel : PageModel
                //        {
                //            private readonly long _fileSizeLimit;

                //            public BufferedSingleFileUploadPhysicalModel(IConfiguration config)
                //            {
                //                _fileSizeLimit = config.GetValue<long>("FileSizeLimit");
                //            }

                //    ...
                //}
                //        When a file size exceeds the limit, the file is rejected:

                //C#

                //Copy
                //if (formFile.Length > _fileSizeLimit)
                //{
                //    // The file is too large ... discontinue processing the file
                //}

                // DTO
                string fileExt = Path.GetExtension(file.FileName);
                string fileLocation = Path.Combine(this.environment.WebRootPath, @"FileFolder\Funds\");
                string path = $"{fileLocation}{file.FileName}";

                // file exists

                using (var stream = new FileStream(path, FileMode.Create))
                {
                    file.CopyTo(stream);
                    stream.Close();
                }

                string startConnection = model.StartConnection.ToString("yyyyMMdd");
                string endConnection = model.EndConnection?.ToString("yyyyMMdd");

                var prosFileTypeDesc = model.UploadEntityFileModel.DocumentType;
                int prosFileTypeId = 0;
                //this.context.TbDomFileType
                //    .Where(ft => ft.FiletypeDesc == prosFileTypeDesc)
                //    .Select(ft => ft.FiletypeId)
                //    .FirstOrDefault();

                this.entitiesFileService.AddDocumentToSpecificEntity(
                                                    file.FileName,
                                                    model.EntityId,
                                                    startConnection,
                                                    endConnection,
                                                    fileExt,
                                                    prosFileTypeId,
                                                    model.ControllerName);

            }

            return this.RedirectToAction("ByIdAndDate", new { model.EntityId, model.ChosenDate });
        }

        //[HttpPost]
        //public IActionResult UploadAgreement(SpecificEntityViewModel model)
        //{
        //    SetModelValuesForSpecificView(model);

        //    //if (!ModelState.IsValid)
        //    //{
        //    //    return this.PartialView("SpecificEntity/_UploadAgr", model);
        //    //}

        //    var file = model.UploadAgreementFileModel.FileToUpload;

        //    if (file != null || file.FileName != "")
        //    {
        //        string fileExt = Path.GetExtension(file.FileName);
        //        string fileLocation = Path.Combine(_environment.WebRootPath, @"FileFolder\Agreements\");
        //        string path = $"{fileLocation}{file.FileName}";

        //        using (var stream = new FileStream(path, FileMode.Create))
        //        {
        //            file.CopyTo(stream);
        //            stream.Close();
        //        }

        //        var activityTypeIdDesc = model.UploadAgreementFileModel.AgrType;
        //        int activityTypeId = this.context.TbDomActivityType
        //                .Where(at => at.AtDesc == activityTypeIdDesc)
        //                .Select(at => at.AtId)
        //                .FirstOrDefault();

        //        string contractDate = model.UploadAgreementFileModel.ContractDate.ToString("yyyyMMdd");
        //        string activationDate = model.UploadAgreementFileModel.ActivationDate.ToString("yyyyMMdd");
        //        string expirationDate = model.UploadAgreementFileModel.ExpirationDate?.ToString("yyyyMMdd");

        //        int statusId = this.context.TbDomAgreementStatus
        //            .Where(s => s.ASDesc == model.UploadAgreementFileModel.Status)
        //            .Select(s => s.ASId)
        //            .FirstOrDefault();

        //        int companyId = this.context.TbCompanies
        //            .Where(c => c.CName == model.UploadAgreementFileModel.Company)
        //            .Select(c => c.CId)
        //            .FirstOrDefault();

        //        this.entitiesFileService.AddAgreementToSpecificEntity(
        //                                            file.FileName,
        //                                            fileExt,
        //                                            model.EntityId,
        //                                            activityTypeId,
        //                                            contractDate,
        //                                            activationDate,
        //                                            expirationDate,
        //                                            statusId,
        //                                            companyId,
        //                                            model.ControllerName);
        //    }

        //    this.ModelState.Clear();
        //    return this.RedirectToAction("ViewEntitySE", new { model.EntityId, model.ChosenDate });
        //}

        //[HttpPost]
        //public IActionResult ReadDocument(string pdfValue)
        //{
        //    FileStreamResult fileStreamResult = null;

        //    string fileLocation = Path.Combine(_environment.WebRootPath, @"FileFolder\Funds\");
        //    string path = $"{fileLocation}{pdfValue}";

        //    if (this.HttpContext.Request.Form.ContainsKey("pdfValue"))
        //    {
        //        var fileStream = new FileStream(path, FileMode.Open, FileAccess.Read);
        //        fileStreamResult = new FileStreamResult(fileStream, "application/pdf");
        //    }

        //    if (fileStreamResult != null)
        //    {
        //        return fileStreamResult;
        //    }

        //    return this.RedirectToAction("All");
        //}

        //[HttpPost]
        //public IActionResult ReadAgreement(string pdfValue)
        //{
        //    FileStreamResult fileStreamResult = null;

        //    string fileLocation = Path.Combine(_environment.WebRootPath, @"FileFolder\Agreements\");
        //    string path = $"{fileLocation}{pdfValue}";

        //    if (this.HttpContext.Request.Form.ContainsKey("pdfValue"))
        //    {
        //        var fileStream = new FileStream(path, FileMode.Open, FileAccess.Read);
        //        fileStreamResult = new FileStreamResult(fileStream, "application/pdf");
        //    }

        //    if (fileStreamResult != null)
        //    {
        //        return fileStreamResult;
        //    }

        //    return this.RedirectToAction("All");
        //}

        //[ValidateAntiForgeryToken]

        //[HttpGet]
        //public JsonResult DeleteAgreement(string agrName)
        //{
        //    if (!string.IsNullOrEmpty(agrName))
        //    {
        //        string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
        //        this.entitiesFileService.DeleteAgreementMapping(agrName, controllerName);

        //        string fileLocation = Path.Combine(_environment.WebRootPath, @"FileFolder\Agreements\");
        //        string path = $"{fileLocation}{agrName}";

        //        if (System.IO.File.Exists(path))
        //        {
        //            System.IO.File.Delete(path);
        //            return Json(new { data = Path.GetFileNameWithoutExtension(agrName) });
        //        }
        //    }

        //    return Json(new { data = "false" });
        //}

        [HttpPost]
        public IActionResult GenerateExcelReport(SpecificEntityViewModel model)
        {
            int count = model.EntitySubEntities.Count;
            if (count > GlobalConstants.RowNumberOfHeadersInTable)
            {
                string typeName = model.GetType().Name;

                return GenerateFileTemplate.ExtractTableAsExcel(model.EntitySubEntities, typeName, GlobalConstants.FundsControllerName);
            }

            return this.Redirect(GlobalConstants.FundAllUrl);
        }

        [HttpPost]
        public IActionResult GeneratePdfReport(SpecificEntityViewModel model)
        {
            int count = model.EntitySubEntities.Count;
            if (count > GlobalConstants.RowNumberOfHeadersInTable)
            {
                // TODO prepare query for less than 16 columns
                //if (model.EntitySubEntities[GlobalConstants.IndexEntityHeadersInSqlTable].Length > GlobalConstants.NumberOfAllowedColumnsInPdfView)
                //{
                //    model.EntitySubEntities = this.fundsService.PrepareFund_SubFundsForPDFExtract(date).ToList();
                //}
                var date = DateTime.ParseExact(model.ChosenDate, GlobalConstants.RequiredWebDateTimeFormat, CultureInfo.InvariantCulture);
                string typeName = model.GetType().Name;
                return GenerateFileTemplate.ExtractTableAsPdf(model.EntitySubEntities, date, typeName, GlobalConstants.FundsControllerName);
            }

            return this.Redirect(GlobalConstants.FundAllUrl);
        }

        private void CallEntitySubEntitiesWithSelectedColumns(SpecificEntityViewModel model, DateTime chosenDate)
        {
            model.EntitySubEntities = this.fundsService
                .GetFund_SubFundsWithSelectedViewAndDate(
                                                model.PreSelectedColumns,
                                                model.SelectedColumns,
                                                chosenDate,
                                                model.EntityId)
                .ToList();
        }

        private void SetModelValuesForSpecificView(SpecificEntityViewModel model)
        {
            model.ControllerName = this.ControllerContext.RouteData.Values[GlobalConstants.ControllerRouteDataValue].ToString();
            var date = DateTime.ParseExact(model.ChosenDate, GlobalConstants.RequiredWebDateTimeFormat, CultureInfo.InvariantCulture);
            int entityId = model.EntityId;

            model.Entity = this.fundsService.GetFundWithDateById(date, entityId).ToList();
            model.EntityDistinctDocuments = this.fundsService.
                GetDistinctFundDocuments(date, entityId).ToList();
            model.EntityDistinctAgreements = this.fundsService.GetDistinctFundAgreements(date, entityId).ToList();

            model.EntitySubEntities = this.fundsService.GetFund_SubFunds(date, entityId).ToList();
            model.EntitiesHeadersForColumnSelection = this.fundsService
                                                                .GetFund_SubFunds(date, entityId)
                                                                .Take(1)
                                                                .ToList();
            model.EntityTimeline = this.fundsService.GetFundTimeline(entityId).ToList();
            model.EntityDocuments = this.fundsService.GetAllFundDocuments(entityId).ToList();
            model.EntityAgreements = this.fundsService.GetAllFundAgreements(date, entityId).ToList();

            model.StartConnection = DateTime.ParseExact(model.Entity.ToList()[1][0], GlobalConstants.SqlDateTimeFormatParsing, CultureInfo.InvariantCulture);

            if (model.EndConnection != null)
            {
                model.EndConnection = DateTime.ParseExact(model.Entity.ToList()[1][1], GlobalConstants.SqlDateTimeFormatParsing, CultureInfo.InvariantCulture);
            }

            //this.ViewData["ProspectusFileTypes"] = this.fundsSelectListService.GetAllProspectusFileTypes();
            //this.ViewData["AgreementsFileTypes"] = this.fundsSelectListService.GetAllAgreementsFileTypes();
            //this.ViewData["AgreementsStatus"] = this.agreementsSelectListService.GetAllTbDomAgreementStatus();
            //this.ViewData["Companies"] = this.agreementsSelectListService.GetAllTbCompanies();
        }
    }
}
