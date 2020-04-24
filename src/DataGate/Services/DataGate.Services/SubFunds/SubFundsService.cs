﻿// Service class for managing subfunds

// Created: 09/2019
// Author:  Philip Shishov

// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
namespace DataGate.Services.SubFunds
{
    using System;
    using System.Data;
    using System.Linq;
    using System.Data.SqlClient;
    using System.Collections.Generic;

    using DataGate.Data;
    using DataGate.Utilities.Services;
    using DataGate.Services.SubFunds.Contracts;

    using Microsoft.Extensions.Configuration;

    // _____________________________________________________________
    public class SubFundsService : ISubFundsService
    {
        private readonly string defaultDate = DateTime.Today.ToString("yyyyMMdd");
        private readonly IConfiguration configuration;
        private readonly Pharus_vFinale_Context context;

        // ________________________________________________________
        //
        // Constructor: initialize with DI IConfiguration
        // to retrieve appsettings.json connection string
        public SubFundsService(
            IConfiguration config,
            Pharus_vFinale_Context context)
        {
            this.configuration = config;
            this.context = context;
        }

        // ________________________________________________________
        //
        // Retrieve query table DB based entities
        // with table functions

        public List<string[]> GetAllSubFunds(DateTime? chosenDate)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from fn_all_subfund('{this.defaultDate}')";
                }
                else
                {
                    command.CommandText = $"select * from fn_all_subfund('{chosenDate?.ToString("yyyyMMdd")}')";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetAllActiveSubFunds()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                command.CommandText = $"select * from fn_active_subfund('{this.defaultDate}')";

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetAllActiveSubFunds(DateTime? chosenDate)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from fn_active_subfund('{this.defaultDate}')";
                }
                else
                {
                    command.CommandText = $"select * from fn_active_subfund('{chosenDate?.ToString("yyyyMMdd")}')";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetAllSubFundsWithSelectedViewAndDate(
                                            List<string> preSelectedColumns, 
                                            List<string> selectedColumns, 
                                            DateTime? chosenDate)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                // Prepare items for DB query with []

                preSelectedColumns.AddRange(selectedColumns);
                preSelectedColumns = preSelectedColumns.Select(c => String.Format("[{0}]", c)).ToList();

                if (chosenDate == null)
                {
                    command.CommandText = $"select {string.Join(", ", preSelectedColumns)} " +
                        $"from fn_all_subfund('{this.defaultDate}')";
                }
                else
                {
                    command.CommandText = $"select {string.Join(", ", preSelectedColumns)} " +
                        $"from fn_all_subfund('{chosenDate?.ToString("yyyyMMdd")}')";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetAllActiveSubFundsWithSelectedViewAndDate(
                                            List<string> preSelectedColumns, 
                                            List<string> selectedColumns, 
                                            DateTime? chosenDate)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                // Prepare items for DB query with []

                preSelectedColumns.AddRange(selectedColumns);
                preSelectedColumns = preSelectedColumns.Select(c => String.Format("[{0}]", c)).ToList();

                if (chosenDate == null)
                {
                    command.CommandText = $"select {string.Join(", ", preSelectedColumns)} " +
                        $"from fn_active_subfund('{this.defaultDate}')";
                }
                else
                {
                    command.CommandText = $"select {string.Join(", ", preSelectedColumns)} " +
                        $"from fn_active_subfund('{chosenDate?.ToString("yyyyMMdd")}')";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string> GetAllSubFundsNames()
        {
            return this.context.TbHistorySubFund
               .Select(f => f.SfOfficialSubFundName)
               .ToList();
        }       

        public List<string[]> GetSubFundWithDateById(DateTime? chosenDate, int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from fn_all_subfund('{this.defaultDate}') where [ID] = {id}";
                }
                else
                {
                    command.CommandText = $"select * from fn_all_subfund('{chosenDate?.ToString("yyyyMMdd")}') where [ID] = {id}";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }      

        public List<string[]> GetSubFund_ShareClasses(DateTime? chosenDate, int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from ActiveShareClassesforSpecificSubFundAtDate('{this.defaultDate}', {id})";
                }
                else
                {
                    command.CommandText = $"select * from ActiveShareClassesforSpecificSubFundAtDate('{chosenDate?.ToString("yyyyMMdd")}', {id})";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetSubFund_ShareClassesWithSelectedViewAndDate(
                       List<string> preSelectedColumns,
                       List<string> selectedColumns,
                       DateTime? chosenDate,
                       int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                // Prepare items for DB query with []

                preSelectedColumns.AddRange(selectedColumns);
                preSelectedColumns = preSelectedColumns.Select(c => String.Format("[{0}]", c)).ToList();

                if (chosenDate == null)
                {
                    command.CommandText = $"select {string.Join(", ", preSelectedColumns)} " +
                        $"from ActiveShareClassesforSpecificSubFundAtDate('{this.defaultDate}', {id})";
                }
                else
                {
                    command.CommandText = $"select {string.Join(", ", preSelectedColumns)} " +
                        $"from ActiveShareClassesforSpecificSubFundAtDate('{chosenDate?.ToString("yyyyMMdd")}', {id})";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetSubFund_FundContainer(DateTime? chosenDate, int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                Dictionary<int, string> funds = new Dictionary<int, string>();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from fn_FundContainerForSubfundAtDate('{this.defaultDate}', {id})";
                }

                else
                {
                    command.CommandText = $"select * from fn_FundContainerForSubfundAtDate('{chosenDate?.ToString("yyyyMMdd")}', {id})";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> PrepareSubFundsForPDFExtract(DateTime? chosenDate)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                command.CommandText = $"select * from fn_active_subfund_pdf('{chosenDate?.ToString("yyyyMMdd")}')";

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> PrepareSubFund_ShareClassesForPDFExtract(DateTime? chosenDate)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                command.CommandText = $"select * from fn_active_shareclass_pdf('{chosenDate?.ToString("yyyyMMdd")}')";

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetSubFundTimeline(int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                command.CommandText = $"select * from dbo.fn_timeline_subfund({id})";

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetDistinctSubFundDocuments(DateTime? chosenDate, int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from [dbo].[fn_view_distinct_documents_subfund]('{this.defaultDate}', {id})";
                }
                else
                {
                    command.CommandText = $"select * from [dbo].[fn_view_distinct_documents_subfund]('{chosenDate?.ToString("yyyyMMdd")}', {id})";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }
        public List<string[]> GetDistinctSubFundAgreements(DateTime? chosenDate, int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from [dbo].[fn_view_distinct_agreements_subfund]('{this.defaultDate}', {id})";
                }
                else
                {
                    command.CommandText = $"select * from [dbo].[fn_view_distinct_agreements_subfund]('{chosenDate?.ToString("yyyyMMdd")}', {id})";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetAllSubFundDocuments(int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                command.CommandText = $"select * from [dbo].[fn_view_documents_subfund]({id})";

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public List<string[]> GetAllSubFundAgreements(DateTime? chosenDate, int id)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                connection.Open();
                SqlCommand command = connection.CreateCommand();

                if (chosenDate == null)
                {
                    command.CommandText = $"select * from [dbo].[fn_view_agreements_subfund]('{this.defaultDate}', {id})";
                }
                else
                {
                    command.CommandText = $"select * from [dbo].[fn_view_agreements_subfund]('{chosenDate?.ToString("yyyyMMdd")}', {id})";
                }

                return CreateModel.CreateModelWithHeadersAndValue(command);
            }
        }

        public void EditSubFund(
                        int sfId,
                        string initialDate,
                        string subFundName,
                        string cssfCode,
                        string faCode,
                        string depCode,
                        string taCode,
                        string firstNavDate,
                        string lastNavDate,
                        string cssfAuthDate,
                        string expiryDate,
                        int sfStatusId,
                        string leiCode,
                        int? cesrClassId,
                        int? geoFocusId,
                        int? glExpId,
                        string currency,
                        int? frequencyId,
                        int? valuationId,
                        int? calculationId,
                        bool isDerivative,
                        int? derivMarketId,
                        int? derivPurposeId,
                        int? principalAssetId,
                        int? typeMarketId,
                        int? principalInvStrId,
                        string clearingCode,
                        int? catMorningStarId,
                        int? catSixId,
                        int? catBloombergId,
                        string comment,
                        string commentTitle)
        {
            string query = "EXEC sp_modify_subfund " +
               "@sf_id, @sf_initialDate, @sf_officialSubFundName, @sf_shortSubFundName," +
               "@sf_cssfCode, @sf_faCode, @sf_depCode, @sf_taCode, @sf_firstNavDate, " +
               "@sf_lastNavDate, @sf_cssfAuthDate, @sf_expDate, @sf_status, @sf_leiCode, " +
               "@sf_cesrClass, @sf_cssf_geographical_focus, @sf_globalExposure, " +
               "@sf_currency, @sf_navFrequency, @sf_valutationDate, @sf_calculationDate, " +
               "@sf_derivatives, @sf_derivMarket, @sf_derivPurpose, @sf_principal_asset_class, " +
               "@sf_type_of_market, @sf_principal_investment_strategy, @sf_clearing_code, " +
               "@sf_cat_morningstar, @sf_category_six, @sf_category_bloomberg, @sf_change_comment, " +
               "@sf_comment_title";

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                using (SqlCommand command = new SqlCommand(query))
                {
                    command.Parameters.AddRange(new[]
                    {
                        new SqlParameter("@sf_id", SqlDbType.Int) { Value = sfId},
                        new SqlParameter("@sf_initialDate", SqlDbType.NVarChar) { Value = initialDate},
                        new SqlParameter("@sf_officialSubFundName", SqlDbType.NVarChar) { Value = subFundName },
                        new SqlParameter("@sf_shortSubFundName", SqlDbType.NVarChar) { Value = subFundName },
                        new SqlParameter("@sf_cssfCode", SqlDbType.NVarChar) { Value = cssfCode },
                        new SqlParameter("@sf_faCode", SqlDbType.NVarChar) { Value = faCode },
                        new SqlParameter("@sf_depCode", SqlDbType.NVarChar) { Value = depCode },
                        new SqlParameter("@sf_taCode", SqlDbType.NVarChar) { Value = taCode },
                        new SqlParameter("@sf_firstNavDate", SqlDbType.NVarChar) { Value = firstNavDate},
                        new SqlParameter("@sf_lastNavDate", SqlDbType.NVarChar) { Value = lastNavDate},
                        new SqlParameter("@sf_cssfAuthDate", SqlDbType.NVarChar) { Value = cssfAuthDate},
                        new SqlParameter("@sf_expDate", SqlDbType.NVarChar) { Value = expiryDate},
                        new SqlParameter("@sf_status", SqlDbType.Int) { Value = sfStatusId },
                        new SqlParameter("@sf_leiCode", SqlDbType.NVarChar) { Value = leiCode },
                        new SqlParameter("@sf_cesrClass", SqlDbType.Int) { Value = cesrClassId },
                        new SqlParameter("@sf_cssf_geographical_focus", SqlDbType.Int) { Value = geoFocusId },
                        new SqlParameter("@sf_globalExposure", SqlDbType.Int) { Value = glExpId },
                        new SqlParameter("@sf_currency", SqlDbType.NChar) { Value = currency },
                        new SqlParameter("@sf_navFrequency", SqlDbType.Int) { Value = frequencyId },
                        new SqlParameter("@sf_valutationDate", SqlDbType.Int) { Value = valuationId },
                        new SqlParameter("@sf_calculationDate", SqlDbType.Int) { Value = calculationId },
                        new SqlParameter("@sf_derivatives", SqlDbType.Bit) { Value = isDerivative },
                        new SqlParameter("@sf_derivMarket", SqlDbType.Int) { Value = derivMarketId },
                        new SqlParameter("@sf_derivPurpose", SqlDbType.Int) { Value = derivPurposeId },
                        new SqlParameter("@sf_principal_asset_class", SqlDbType.Int) { Value = principalAssetId },
                        new SqlParameter("@sf_type_of_market", SqlDbType.Int) { Value = typeMarketId },
                        new SqlParameter("@sf_principal_investment_strategy", SqlDbType.Int) { Value = principalInvStrId },
                        new SqlParameter("@sf_clearing_code", SqlDbType.NVarChar) { Value = clearingCode },
                        new SqlParameter("@sf_cat_morningstar", SqlDbType.Int) { Value = catMorningStarId },
                        new SqlParameter("@sf_category_six", SqlDbType.Int) { Value = catSixId },
                        new SqlParameter("@sf_category_bloomberg", SqlDbType.Int) { Value = catBloombergId },
                        new SqlParameter("@sf_change_comment", SqlDbType.NVarChar) { Value = comment },
                        new SqlParameter("@sf_comment_title", SqlDbType.NVarChar) { Value = commentTitle }
                    });

                    foreach (SqlParameter parameter in command.Parameters)
                    {
                        if (parameter.Value == null)
                        {
                            parameter.Value = DBNull.Value;
                            
                        }
                    }

                    command.Connection = connection;

                    try
                    {
                        command.Connection.Open();
                        command.ExecuteScalar();
                    }
                    catch (SqlException sx)
                    {
                        Console.WriteLine(sx.Message);
                    }
                }
            }
        }

        public void CreateSubFund(
                        string initialDate,
                        string endDate,
                        string subFundName,
                        string cssfCode,
                        string faCode,
                        string depCode,
                        string taCode,
                        string firstNavDate,
                        string lastNavDate,
                        string cssfAuthDate,
                        string expiryDate,
                        int sfStatusId,
                        string leiCode,
                        int? cesrClassId,
                        int? geoFocusId,
                        int? glExpId,
                        string currency,
                        int? frequencyId,
                        int? valuationId,
                        int? calculationId,
                        bool isDerivative,
                        int? derivMarketId,
                        int? derivPurposeId,
                        int? principalAssetId,
                        int? typeMarketId,
                        int? principalInvStrId,
                        string clearingCode,
                        int? catMorningStarId,
                        int? catSixId,
                        int? catBloombergId,
                        int fundContainerId
                        )
        {
            string query = "EXEC sp_new_subfund " +
                "@sf_initialDate, @sf_endDate, @sf_officialSubFundName, " +
                "@sf_cssfCode, @sf_faCode, @sf_depCode, @sf_taCode, @sf_firstNavDate, " +
                "@sf_lastNavDate, @sf_cssfAuthDate, @sf_expDate, @sf_status, @sf_leiCode, " +
                "@sf_cesrClass, @sf_cssf_geographical_focus, @sf_globalExposure, " +
                "@sf_currency, @sf_navFrequency, @sf_valutationDate, @sf_calculationDate, " +
                "@sf_derivatives, @sf_derivMarket, @sf_derivPurpose, @sf_principal_asset_class, " +
                "@sf_type_of_market, @sf_principal_investment_strategy, @sf_clearing_code, " +
                "@sf_cat_morningstar, @sf_category_six, @sf_category_bloomberg, @fundcontainer";

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = this.configuration.GetConnectionString("Pharus_vFinaleConnection");
                using (SqlCommand command = new SqlCommand(query))
                {
                    command.Parameters.AddRange(new[]
                    {
                        new SqlParameter("@sf_initialDate", SqlDbType.NVarChar) { Value = initialDate},
                        new SqlParameter("@sf_endDate", SqlDbType.NVarChar) { Value = endDate},
                        new SqlParameter("@sf_officialSubFundName", SqlDbType.NVarChar) { Value = subFundName },
                        new SqlParameter("@sf_cssfCode", SqlDbType.NVarChar) { Value = cssfCode },
                        new SqlParameter("@sf_faCode", SqlDbType.NVarChar) { Value = faCode },
                        new SqlParameter("@sf_depCode", SqlDbType.NVarChar) { Value = depCode },
                        new SqlParameter("@sf_taCode", SqlDbType.NVarChar) { Value = taCode },
                        new SqlParameter("@sf_firstNavDate", SqlDbType.NVarChar) { Value = firstNavDate},
                        new SqlParameter("@sf_lastNavDate", SqlDbType.NVarChar) { Value = lastNavDate},
                        new SqlParameter("@sf_cssfAuthDate", SqlDbType.NVarChar) { Value = cssfAuthDate},
                        new SqlParameter("@sf_expDate", SqlDbType.NVarChar) { Value = expiryDate},
                        new SqlParameter("@sf_status", SqlDbType.Int) { Value = sfStatusId },
                        new SqlParameter("@sf_leiCode", SqlDbType.NVarChar) { Value = leiCode },
                        new SqlParameter("@sf_cesrClass", SqlDbType.Int) { Value = cesrClassId },
                        new SqlParameter("@sf_cssf_geographical_focus", SqlDbType.Int) { Value = geoFocusId },
                        new SqlParameter("@sf_globalExposure", SqlDbType.Int) { Value = glExpId },
                        new SqlParameter("@sf_currency", SqlDbType.NChar) { Value = currency },
                        new SqlParameter("@sf_navFrequency", SqlDbType.Int) { Value = frequencyId },
                        new SqlParameter("@sf_valutationDate", SqlDbType.Int) { Value = valuationId },
                        new SqlParameter("@sf_calculationDate", SqlDbType.Int) { Value = calculationId },
                        new SqlParameter("@sf_derivatives", SqlDbType.Bit) { Value = isDerivative },
                        new SqlParameter("@sf_derivMarket", SqlDbType.Int) { Value = derivMarketId },
                        new SqlParameter("@sf_derivPurpose", SqlDbType.Int) { Value = derivPurposeId },
                        new SqlParameter("@sf_principal_asset_class", SqlDbType.Int) { Value = principalAssetId },
                        new SqlParameter("@sf_type_of_market", SqlDbType.Int) { Value = typeMarketId },
                        new SqlParameter("@sf_principal_investment_strategy", SqlDbType.Int) { Value = principalInvStrId },
                        new SqlParameter("@sf_clearing_code", SqlDbType.NVarChar) { Value = clearingCode },
                        new SqlParameter("@sf_cat_morningstar", SqlDbType.Int) { Value = catMorningStarId },
                        new SqlParameter("@sf_category_six", SqlDbType.Int) { Value = catSixId },
                        new SqlParameter("@sf_category_bloomberg", SqlDbType.Int) { Value = catBloombergId },
                        new SqlParameter("@fundcontainer", SqlDbType.Int) { Value = fundContainerId },
                    });

                    foreach (SqlParameter parameter in command.Parameters)
                    {
                        if (parameter.Value == null)
                        {
                            parameter.Value = DBNull.Value;
                        }
                    }

                    command.Connection = connection;

                    try
                    {
                        command.Connection.Open();
                        command.ExecuteScalar();
                    }
                    catch (SqlException sx)
                    {
                        Console.WriteLine(sx.Message);
                    }
                }
            }
        }
    }
}