﻿// Copyright (c) DataGate Project. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

namespace DataGate.Services.Data.Tests.Files
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;

    using DataGate.Common.Exceptions;
    using DataGate.Services.Data.Files;
    using DataGate.Services.Data.Tests.TestData;
    using DataGate.Web.InputModels.Files;

    using Xunit;
    using Xunit.Priority;

    [TestCaseOrderer(PriorityOrderer.Name, PriorityOrderer.Assembly)]
    public class FileServiceTests : SqlServerContextProvider
    {
        private readonly FileService service;
        private readonly int tbMapFileFundCount;
        private readonly int tbSAFundCount;
        private readonly int tbFileCount;

        public FileServiceTests()
        {
            this.service = FileServiceTestData.Service(base.Context, base.Configuration);
            this.tbMapFileFundCount = base.Context.TbMapFilefund.Count();
            this.tbFileCount = base.Context.TbFile.Count();
            this.tbSAFundCount = base.Context.TbServiceAgreementFund.Count();
        }

        #region Delete

        [Fact, Priority(0)]
        public async Task DeleteDocument_Fund_ShouldDecreaseCount()
        {
            var document = this.SetDocumentValues();

            using (base.Context)
            {
                await this.service.UploadDocument(document);

                Assert.Equal(this.tbMapFileFundCount + 1, base.Context.TbMapFilefund.Count());
                Assert.Equal(this.tbFileCount + 1, base.Context.TbFile.Count());

                await this.service.DeleteDocument(3, "Fund");

                Assert.Equal(this.tbMapFileFundCount, base.Context.TbMapFilefund.Count());
                Assert.Equal(this.tbFileCount, base.Context.TbFile.Count());
            }
        }

        [Theory]
        [InlineData(-5)]
        [InlineData(0)]
        [InlineData(100000)]
        public async Task DeleteDocument_Fund_WithInvalidId_ShouldThrowException(int fileId)
        {
            async Task task() => await this.service.DeleteDocument(fileId, "Fund");

            await Assert.ThrowsAsync<EntityNotFoundException>(task);
        }

        [Fact, Priority(1)]
        public async Task DeleteAgreement_Fund_ShouldDecreaseCount()
        {
            var agreement = SetAgreementValues();

            using (base.Context)
            {
                await this.service.UploadAgreement(agreement);

                Assert.Equal(this.tbSAFundCount + 1, base.Context.TbServiceAgreementFund.Count());
                Assert.Equal(this.tbFileCount + 1, base.Context.TbFile.Count());

                await this.service.DeleteAgreement(3, "Fund");

                Assert.Equal(this.tbSAFundCount, base.Context.TbServiceAgreementFund.Count());
                Assert.Equal(this.tbFileCount, base.Context.TbFile.Count());
            }
        }

        [Theory]
        [InlineData(-5)]
        [InlineData(0)]
        [InlineData(100000)]
        public async Task DeleteAgreement_Fund_WithInvalidId_ShouldThrowException(int fileId)
        {
            async Task task() => await this.service.DeleteAgreement(fileId, "Fund");

            await Assert.ThrowsAsync<EntityNotFoundException>(task);
        }

        #endregion

        #region Upload

        [Fact]
        public async Task UploadDocument_Fund_ShouldIncreaseCount()
        {
            var document = this.SetDocumentValues();

            using (base.Context)
            {
                await this.service.UploadDocument(document);

                Assert.Equal(this.tbMapFileFundCount + 1, base.Context.TbMapFilefund.Count());
                Assert.Equal(this.tbFileCount + 1, base.Context.TbFile.Count());
            }
        }

        [Fact]
        public async Task UploadDocument_Fund_ExistingFile_ShouldIncreaseCount()
        {
            var document = this.SetDocumentValuesWithExistingFile();

            using (base.Context)
            {
                await this.service.UploadDocument(document);

                Assert.Equal(this.tbMapFileFundCount + 1, base.Context.TbMapFilefund.Count());
                Assert.Equal(this.tbFileCount + 1, base.Context.TbFile.Count());
            }
        }

        [Theory]
        [InlineData(-5, "2020-01-01")]
        [InlineData(100, "2020-01-01")]
        [InlineData(11, "2020-01-01")]
        public async Task UploadDocument_Fund_WithUnvalidData_ShouldThrowException(int fundId, string date)
        {
            var startConnection = DateTime.Parse(date);
            var document = FileServiceTestData.Generate(fundId, startConnection);

            async Task task() => await this.service.UploadDocument(document);

            await Assert.ThrowsAsync<CustomSqlException>(task);
        }

        [Theory]
        [InlineData("")]
        [InlineData("       ")]
        [InlineData("Invalid")]
        [InlineData(null)]
        public async Task UploadDocument_Fund_WithUnvalidDocType_ShouldThrowException(string docType)
        {
            var document = this.SetDocumentValues(docType);

            async Task task() => await this.service.UploadDocument(document);

            await Assert.ThrowsAsync<ArgumentNullException>(task);
        }

        [Fact]
        public async Task UploadAgreement_Fund_ShouldIncreaseCount()
        {
            var agreement = SetAgreementValues();

            using (base.Context)
            {
                await this.service.UploadAgreement(agreement);

                Assert.Equal(this.tbSAFundCount + 1, base.Context.TbServiceAgreementFund.Count());
                Assert.Equal(this.tbFileCount + 1, base.Context.TbFile.Count());
            }
        }

        [Fact]
        public async Task UploadAgreement_Fund_ExistingFile_ShouldIncreaseCount()
        {
            var agreement = SetAgreementValuesWithExistingFile();

            using (base.Context)
            {
                await this.service.UploadAgreement(agreement);

                Assert.Equal(this.tbSAFundCount + 1, base.Context.TbServiceAgreementFund.Count());
                Assert.Equal(this.tbFileCount + 1, base.Context.TbFile.Count());
            }
        }

        [Theory]
        [InlineData(-5)]
        [InlineData(100)]
        [InlineData(100000)]
        public async Task UploadAgreement_Fund_WithUnvalidId_ShouldThrowException(int fundId)
        {
            var agreement = FileServiceTestData.Generate(fundId, "20160101");

            async Task task() => await this.service.UploadAgreement(agreement);

            await Assert.ThrowsAsync<CustomSqlException>(task);
        }

        [Theory]
        [InlineData("")]
        [InlineData("       ")]
        [InlineData("Invalid")]
        [InlineData(null)]
        public async Task UploadAgreement_Fund_WithUnvalidAgrType_ShouldThrowException(string agrType)
        {
            var agreement = SetAgreementValues(agrType);

            async Task task() => await this.service.UploadAgreement(agreement);

            await Assert.ThrowsAsync<ArgumentNullException>(task);
        }

        #endregion

        private UploadAgreementInputModel SetAgreementValues(string agrType = "Management Company Agreement")
        {
            var fundId = 16;
            var tbSaAgr = base.Context.TbServiceAgreementFund.ToList();
            var activationDate = DateTime.Now.ToString();

            return FileServiceTestData.Generate(fundId, activationDate, agrType);
        }

        private UploadDocumentInputModel SetDocumentValues(string docType = "Prospectus")
        {
            var fundId = 16;
            var tbMapFile = base.Context.TbMapFilefund.ToList();
            var startConnection = DateTime.Now;

            return FileServiceTestData.Generate(fundId, startConnection, docType);
        }

        private UploadAgreementInputModel SetAgreementValuesWithExistingFile(string agrType = "Management Company Agreement")
        {
            var fundId = 1;
            var tbSaAgr = base.Context.TbServiceAgreementFund.ToList();
            var activationDate = tbSaAgr
                .Where(x => x.SaFundId == fundId)
                .Select(x => x.SaActivationDate)
                .FirstOrDefault();

            return FileServiceTestData.Generate(fundId, activationDate.ToString(), agrType);
        }

        private UploadDocumentInputModel SetDocumentValuesWithExistingFile(string docType = "Prospectus")
        {
            var fundId = 11;
            var tbMapFile = base.Context.TbMapFilefund.ToList();
            var startConnection = tbMapFile
                .Where(x => x.DocFundId == fundId)
                .Select(x => (DateTime)x.DocEndConnection)
                .FirstOrDefault();

            return FileServiceTestData.Generate(fundId, startConnection.AddDays(1), docType);
        }
    }
}
