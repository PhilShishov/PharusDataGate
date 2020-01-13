﻿namespace Pharus.App.Controllers
{
    using System;
    using System.Linq;
    using System.Globalization;
    using System.Collections.Generic;

    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Authorization;

    using Pharus.Data;
    using Pharus.App.Utilities;
    using Pharus.Services.Files;
    using Pharus.App.Models.ViewModels.Entities;
    using Pharus.Services.ShareClasses.Contracts;
    using Pharus.App.Models.BindingModels.ShareClasses;
    using Pharus.Utilities.App;

    [Authorize]
    public class ShareClassesController : Controller
    {
        private readonly Pharus_vFinale_Context context;
        private readonly IShareClassesService shareClassesService;
        private readonly IShareClassesSelectListService shareClassesSelectListService;
        private readonly IEntitiesFileService entitiesFileService;
        private readonly IHostingEnvironment hostingEnvironment;

        public ShareClassesController(
            IShareClassesService shareClassesService,
            IShareClassesSelectListService shareClassesSelectListService,
            Pharus_vFinale_Context context,
            IEntitiesFileService entitiesFileService,
            IHostingEnvironment hostingEnvironment)
        {
            this.context = context;
            this.hostingEnvironment = hostingEnvironment;
            this.shareClassesService = shareClassesService;
            this.shareClassesSelectListService = shareClassesSelectListService;
            this.entitiesFileService = entitiesFileService;
        }

        [HttpGet]
        public IActionResult All()
        {
            var model = new EntitiesViewModel
            {
                IsActive = true,
                ChosenDate = DateTime.Today.ToString("yyyy-MM-dd"),
                EntitiesHeadersForColumnSelection = this.shareClassesService.GetAllActiveShareClasses().Take(1).ToList(),
                Entities = this.shareClassesService.GetAllActiveShareClasses(),
            };

            this.ModelState.Clear();
            return this.View(model);
        }

        public JsonResult AutoCompleteShareClassesList(string selectTerm)
        {
            var result = this.context
                .TbHistoryShareClass
                .GroupBy(hsc => hsc.ScOfficialShareClassName)
                .Select(hsc => hsc.FirstOrDefault())
                .ToList();

            if (selectTerm != null)
            {
                result = this.context
                    .TbHistoryShareClass
                    .Where(hsc => hsc.ScOfficialShareClassName.Contains(selectTerm))
                    .GroupBy(hsc => hsc.ScOfficialShareClassName)
                    .Select(hsc => hsc.FirstOrDefault())
                    .ToList();
            }

            var modifiedData = result.Select(hsc => new
            {
                id = hsc.ScOfficialShareClassName,
                text = hsc.ScOfficialShareClassName,
            });

            return this.Json(modifiedData);
        }

        [HttpPost]
        public IActionResult All(EntitiesViewModel model)
        {
            // ---------------------------------------------------------
            //
            // Available header column selection
            model.EntitiesHeadersForColumnSelection = this.shareClassesService.GetAllActiveShareClasses().Take(1).ToList();

            bool isInSelectionMode = false;

            if (model.SelectedColumns != null && model.SelectedColumns.Count > 0)
            {
                isInSelectionMode = true;
            }

            DateTime? chosenDate = null;

            if (model.ChosenDate != null)
            {
                chosenDate = DateTime.ParseExact(model.ChosenDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            }

            if (isInSelectionMode)
            {
                if (model.IsActive)
                {
                    CallActiveEntitiesWithSelectedColumns(model, chosenDate);
                }
                else if (!model.IsActive)
                {
                    CallAllEntitiesWithSelectedColumns(model, chosenDate);
                }
            }
            else if (!isInSelectionMode)
            {
                if (model.IsActive)
                {
                    model.Entities = this.shareClassesService.GetAllActiveShareClasses(chosenDate);
                }
                else if (!model.IsActive)
                {
                    model.Entities = this.shareClassesService.GetAllShareClasses(chosenDate);
                }
            }

            if (model.SelectTerm != null)
            {
                model.Entities = CreateTableView.AddTableToView(model.Entities, model.SelectTerm.ToLower());
            }

            if (model.SearchTerm != null)
            {
                model.Entities = CreateTableView.AddTableToView(model.Entities, model.SearchTerm.ToLower());
            }

            if (model.Entities != null)
            {
                return this.View(model);
            }

            return this.RedirectToPage("/ShareClasses/All");
        }

        [HttpPost]
        public FileStreamResult ExtractExcelEntities(EntitiesViewModel model)
        {
            FileStreamResult fileStreamResult = null;

            string typeName = model.GetType().Name;
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();

            if (this.HttpContext.Request.Form.ContainsKey("extract_Excel"))
            {
                fileStreamResult = ExtractTable.ExtractTableAsExcel(model.Entities, typeName, controllerName);
            }

            return fileStreamResult;
        }

        [HttpPost]
        public FileStreamResult ExtractPdfEntities(EntitiesViewModel model)
        {
            FileStreamResult fileStreamResult = null;

            var chosenDate = DateTime.ParseExact(model.ChosenDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            string typeName = model.GetType().Name;
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();

            if (this.HttpContext.Request.Form.ContainsKey("extract_Pdf"))
            {
                fileStreamResult = ExtractTable.ExtractTableAsPdf(model.Entities, chosenDate, this.hostingEnvironment, typeName, controllerName);
            }

            return fileStreamResult;
        }

        //[HttpGet("ShareClasses/ViewEntitySE/{EntityId}/{ChosenDate}")]
        //public IActionResult ViewEntitySE(int entityId, string chosenDate)
        //{
        //    SpecificEntityViewModel viewModel = new SpecificEntityViewModel
        //    {
        //        ChosenDate = chosenDate,
        //        EntityId = entityId,
        //        Entity = this.shareClassesService.GetShareClassById(entityId),
        //        EntityTimeline = this.shareClassesService.GetShareClassesTimeline(entityId),
        //        EntityDocuments = this.shareClassesService.GetAllShareClassesDocumens(entityId),
        //        BaseEntityName = this.shareClassesService.GetShareClass_SubFundContainer(entityId)[1][1],
        //        BaseEntityId = this.shareClassesService.GetShareClass_SubFundContainer(entityId)[1][0],
        //        TSPriceDates = this.shareClassesService
        //        .GetShareClassTimeSeriesDates(entityId)
        //        .Skip(1)
        //        .Select(ts => ts[1])
        //        .ToList(),
        //        TSTableType = this.shareClassesService
        //        .GetTimeseriesTypeProviders(entityId)
        //        .Skip(1)
        //        .Select(tt => tt[0])
        //        .ToList(),
        //        TSPriceBloombergEUR = this.shareClassesService
        //        .GetShareClassTimeSeries(entityId)
        //        .Skip(1)
        //        .Where(ts => ts[2] == "Bloomberg EUR")
        //        .Select(ts => ts[1])
        //        .ToList(),
        //        TSPriceBloombergUSD = this.shareClassesService
        //        .GetShareClassTimeSeries(entityId)
        //        .Skip(1)
        //        .Where(ts => ts[2] == "Bloomberg USD")
        //        .Select(ts => ts[1])
        //        .ToList(),
        //        TSPriceSixUSD = this.shareClassesService
        //        .GetShareClassTimeSeries(entityId)
        //        .Skip(1)
        //        .Where(ts => ts[2] == "SiX EUR")
        //        .Select(ts => ts[1])
        //        .ToList(),
        //    };           

        //    //this.ViewData["FileTypes"] = this.subfundsSelectListService.GetAllSubFundFileTypes();

        //    HttpContext.Session.SetString("entityId", Convert.ToString(entityId));

        //    //string fileName = GetFileNameFromFilePath(entityId, chosenDate);

        //    //if (string.IsNullOrEmpty(fileName))
        //    //{
        //    //    return this.View(viewModel);
        //    //}

        //    //viewModel.FileNameToDisplay = fileName;

        //    this.ModelState.Clear();
        //    return this.View(viewModel);
        //}

        //[HttpPost("ShareClasses/ViewEntitySE/{EntityId}")]
        //public IActionResult ViewEntitySE(EntitiesViewModel viewModel)
        //{
        //    viewModel.Entities = this.shareClassesService.GetShareClassById(viewModel.EntityId);

        //    var chosenDate = DateTime.ParseExact(viewModel.ChosenDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

        //    if (viewModel.Command.Equals("Update Table"))
        //    {
        //        if (viewModel.ChosenDate != null)
        //        {
        //            viewModel.Entities = this.shareClassesService.GetShareClassById(chosenDate, viewModel.EntityId);
        //        }
        //    }

        //    if (viewModel.Entities != null)
        //    {
        //        return this.View(viewModel);
        //    }

        //    return this.View();
        //}

        //[HttpGet("ShareClasses/EditShareClass/{EntityId}")]
        //public IActionResult EditShareClass(int entityId)
        //{
        //    ShareClassBindingModel model = new ShareClassBindingModel
        //    {
        //        EntityProperties = this.shareClassesService.GetShareClassWithDateById(entityId),
        //        InvestorType = new SelectList(this.shareClassesSelectListService.GetAllTbDomInvestorType()),
        //        CurrencyCode = new SelectList(this.shareClassesSelectListService.GetAllTbDomCurrencyCode()),
        //        CountryIssue = new SelectList(this.shareClassesSelectListService.GetAllTbDomCountry()),
        //        CountryRisk = new SelectList(this.shareClassesSelectListService.GetAllTbDomCountry()),
        //        ShareStatus = new SelectList(this.shareClassesSelectListService.GetAllTbDomShareStatus()),
        //        ShareType = new SelectList(this.shareClassesSelectListService.GetAllTbDomShareType()),
        //    };

        //    return this.View(model);
        //}

        //[HttpPost]
        //public IActionResult EditShareClass(ShareClassBindingModel model)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return View(model ?? new ShareClassBindingModel());
        //    }
        //    int entityId = int.Parse(model.EntityProperties[1][0]);
        //    string returnUrl = $"/ShareClasses/ViewEntitySE/{entityId}";

        //    var shareClass = this.shareClassesService.GetShareClassById(entityId);

        //    if (this.HttpContext.Request.Form.ContainsKey("modify_button"))
        //    {
        //        for (int row = 1; row < shareClass.Count; row++)
        //        {
        //            for (int col = 0; col < shareClass[row].Length; col++)
        //            {
        //                shareClass[row][col] = model.EntityProperties[row][col];
        //            }
        //        }

        //        return this.LocalRedirect(returnUrl);
        //    }

        //    return this.LocalRedirect(returnUrl);
        //}

        //[HttpGet]
        //public IActionResult CreateShareClass()
        //{
        //    ShareClassBindingModel model = new ShareClassBindingModel
        //    {
        //        EntityProperties = this.shareClassesService.GetAllShareClasses(),
        //        InvestorType = new SelectList(this.shareClassesSelectListService.GetAllTbDomInvestorType()),
        //        CurrencyCode = new SelectList(this.shareClassesSelectListService.GetAllTbDomCurrencyCode()),
        //        CountryIssue = new SelectList(this.shareClassesSelectListService.GetAllTbDomCountry()),
        //        CountryRisk = new SelectList(this.shareClassesSelectListService.GetAllTbDomCountry()),
        //        ShareStatus = new SelectList(this.shareClassesSelectListService.GetAllTbDomShareStatus()),
        //        ShareType = new SelectList(this.shareClassesSelectListService.GetAllTbDomShareType()),
        //    };

        //    return this.View(model);
        //}

        private void CallAllEntitiesWithSelectedColumns(EntitiesViewModel model, DateTime? chosenDate)
        {
            model.Entities = this.shareClassesService.GetAllShareClassesWithSelectedViewAndDate(
                model.PreSelectedColumns,
                model.SelectedColumns,
                chosenDate);
        }

        private void CallActiveEntitiesWithSelectedColumns(EntitiesViewModel model, DateTime? chosenDate)
        {
            model.Entities = this.shareClassesService.GetAllActiveShareClassesWithSelectedViewAndDate(
                                        model.PreSelectedColumns,
                                        model.SelectedColumns,
                                        chosenDate);
        }
    }
}