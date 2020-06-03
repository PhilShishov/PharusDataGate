﻿namespace DataGate.Services.Data.SubFunds
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;

    using DataGate.Common.Exceptions;
    using DataGate.Data.Common.Repositories;
    using DataGate.Data.Models.Entities;
    using DataGate.Services.Data.SubFunds.Contracts;
    using DataGate.Services.Mapping;
    using DataGate.Services.SqlClient.Contracts;
    using DataGate.Web.Dtos.Queries;

    public class SubFundDetailsService : ISubFundDetailsService
    {
        // ________________________________________________________
        //
        // Table functions names as in DB
        private readonly string sqlFunctionById = "[fn_subfund_id]";
        private readonly string sqlFunctionContainer = "[fn_subfund_fund_container]";
        private readonly string sqlFunctionDistinctDocuments = "[fn_view_distinct_documents_subfund]";
        private readonly string sqlFunctionDistinctAgreements = "[fn_view_distinct_agreements_subfund]";

        private readonly ISqlQueryManager sqlManager;
        private readonly IRepository<TbHistorySubFund> repository;

        // ________________________________________________________
        //
        // Constructor: initialize with DI IConfiguration
        // to retrieve appsettings.json connection string
        public SubFundDetailsService(
                    ISqlQueryManager sqlQueryManager,
                    IRepository<TbHistorySubFund> repository)
        {
            this.repository = repository;
            this.sqlManager = sqlQueryManager;
        }

        // ________________________________________________________
        //
        // Retrieve query table DB based entities
        // with table functions
        public IEnumerable<string[]> GetByIdAndDate(int id, DateTime? date)
        {
            return this.sqlManager.ExecuteQuery(this.sqlFunctionById, date, id);
        }

        public ContainerDto GetContainer(int id, DateTime? date)
            => this.sqlManager.ExecuteQueryMapping<ContainerDto>(this.sqlFunctionContainer, id, date).FirstOrDefault();

        public IEnumerable<DistinctDocDto> GetDistinctDocuments(int id, DateTime? date)
        {
            var query = this.sqlManager
                .ExecuteQuery(this.sqlFunctionDistinctDocuments, date, id)
                .ToList();

            var dto = new List<DistinctDocDto>();

            for (int row = 1; row < query.Count; row++)
            {
                for (int col = 0; col < row; col++)
                {
                    var document = new DistinctDocDto
                    {
                        Name = query[row][col],
                        FileId = int.Parse(query[row][col + 1]),
                    };
                    dto.Add(document);
                }
            }

            return dto;
        }

        public IEnumerable<DistinctAgrDto> GetDistinctAgreements(int id, DateTime? date)
                => this.sqlManager.ExecuteQueryMapping<DistinctAgrDto>(this.sqlFunctionDistinctAgreements, id, date);

        public void ThrowEntityNotFoundExceptionIfIdDoesNotExist(int id)
        {
            if (!this.Exists(id))
            {
                throw new EntityNotFoundException(nameof(TbHistorySubFund));
            }
        }

        private bool Exists(int id) => this.repository.All().Any(x => x.SfId == id);
    }
}
