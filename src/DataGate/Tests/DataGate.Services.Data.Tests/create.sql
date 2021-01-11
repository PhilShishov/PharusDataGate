USE [master]
GO
CREATE DATABASE [DataGate_Test]
GO
USE [DataGate_Test]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_historyFund](
	[f_id] [int] NOT NULL,
	[f_initial_date] [datetime] NOT NULL,
	[f_end_date] [datetime] NULL,
	[f_status] [int] NULL,
	[f_registration_number] [nvarchar](100) NULL,
	[f_official_fund_name] [nvarchar](100) NULL,
	[f_short_fund_name] [nvarchar](100) NULL,
	[f_lei_code] [nvarchar](100) NULL,
	[f_cssf_code] [nvarchar](100) NULL,
	[f_fa_code] [nvarchar](100) NULL,
	[f_dep_code] [nvarchar](100) NULL,
	[f_ta_code] [nvarchar](100) NULL,
	[f_legal_form] [int] NULL,
	[f_legal_type] [int] NULL,
	[f_legal_vehicle] [int] NULL,
	[f_company_type] [int] NULL,
	[f_tin_number] [nvarchar](100) NULL,
	[f_change_comment] [nvarchar](max) NULL,
	[f_comment_title] [nvarchar](50) NULL,
	[f_vat_registration_number] [nvarchar](100) NULL,
	[f_vat_identification_number] [nvarchar](100) NULL,
	[f_ibic_number] [nvarchar](100) NULL,
	[f_fund_admin] [int] NULL,
 CONSTRAINT [PK_tb_fund] PRIMARY KEY CLUSTERED 
(
	[f_id] ASC,
	[f_initial_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_timeline_fund]
(	
		@id_fund int
)
RETURNS TABLE 
AS
RETURN 
(
	 select 
		 f_id [ID],
	 convert(varchar,f_initial_date, 103) [INITIAL DATE],
	 convert(varchar,f_end_date, 103) [END DATE], 
	 f_comment_title [COMMENT TITLE],
	 f_change_comment [COMMENT]
	 from tb_historyFund hf 
	 where hf.f_id=@id_fund
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_company_type](
	[ct_id] [int] NOT NULL,
	[ct_desc] [varchar](100) NOT NULL,
	[ct_acronym] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tb_dom_companyType] PRIMARY KEY CLUSTERED 
(
	[ct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_f_status](
	[st_f_id] [int] NOT NULL,
	[st_f_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_f_status] PRIMARY KEY CLUSTERED 
(
	[st_f_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_legal_form](
	[lf_id] [int] NOT NULL,
	[lf_acronym] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tb_dom_legal_form] PRIMARY KEY CLUSTERED 
(
	[lf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_legal_vehicle](
	[lv_id] [int] NOT NULL,
	[lv_acronym] [varchar](100) NOT NULL,
	[lv_fk_legal_type] [int] NOT NULL,
 CONSTRAINT [PK_tb_dom_legal_vehicle] PRIMARY KEY CLUSTERED 
(
	[lv_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_fund_admin_type](
	[fat_id] [int] IDENTITY(1,1) NOT NULL,
	[fat_desc] [varchar](100) NOT NULL,
	[fat_acronym] [nchar](5) NOT NULL,
 CONSTRAINT [PK__tb_dom_fund_admin_type] PRIMARY KEY CLUSTERED 
(
	[fat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_legal_type](
	[lt_id] [int] NOT NULL,
	[lt_acronym] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tb_dom_legalType] PRIMARY KEY CLUSTERED 
(
	[lt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_fund_id]
(	
		@report_date date,
		@fundid as int
)
RETURNS TABLE 
AS
RETURN 
(

select 
[FUND ID],
[VALID FROM],
	case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL] ,
[FUND NAME],
[STATUS],
[CSSF CODE],
[LEGAL FORM],
[LEGAL VEHICLE],
[LEGAL TYPE],
[FUND ADMIN CODE],
[DEP. CODE],
[TRANSFER AGENT CODE],
[COMPANY DESCRIPTION],
[COMPANY TYPE],
[TIN NUMBER],
[LEI CODE],
[REG. NUMBER],
[VAT REG. NUMBER],
[VAT IDENT. NUMBER],
[I.B.I.C. NUMBER]
from (

SELECT 
 convert(varchar, f.f_initial_date, 103)[VALID FROM],
			convert(varchar, f.f_end_date, 103) [VALID UNTIL],
			f.f_id [FUND ID],
			f.f_official_fund_name [FUND NAME],  
			f.f_cssf_code [CSSF CODE],  
			ft.st_f_desc [STATUS], 
			lf.lf_acronym [LEGAL FORM],  
			lv.lv_acronym [LEGAL VEHICLE], 
			lt.lt_acronym [LEGAL TYPE], 
			CONCAT(fat.fat_acronym, '- ',  f_fa_code ) [FUND ADMIN CODE],
			f_dep_code [DEP. CODE],
			f_ta_code [TRANSFER AGENT CODE],
			ct.ct_desc [COMPANY DESCRIPTION],  
			CT.ct_acronym [COMPANY TYPE], 
			f.f_tin_number [TIN NUMBER], 
			f.f_lei_code [LEI CODE],
			f.f_registration_number [REG. NUMBER],
						f.f_vat_registration_number [VAT REG. NUMBER],
						f.f_vat_Identification_number [VAT IDENT. NUMBER],
						f.f_ibic_number [I.B.I.C. NUMBER]
	
	FROM tb_historyFund f
				left join tb_dom_f_status ft  on ft.st_f_id=f.f_status
				left join tb_dom_legal_form lf on lf.lf_id=f.f_legal_form
				left join tb_dom_legal_vehicle lv on lv.lv_id=f.f_legal_vehicle
				left join tb_dom_legal_type lt on lt.lt_id=f.f_legal_type
				left join tb_dom_company_type ct on ct.ct_id=f.f_company_type
								left join tb_dom_fund_admin_type fat on fat.fat_id=f.f_fund_admin


	Where (@fundid = f.f_id) AND (@report_date between f.f_initial_date and f.f_end_date  OR (@report_date >= f.f_initial_date and f.f_end_date is null))
	)tb2
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_fundSubFund](
	[sf_id] [int] NOT NULL,
	[f_id] [int] NOT NULL,
	[fsf_startConnection] [datetime] NOT NULL,
	[fsf_endConnection] [datetime] NULL,
 CONSTRAINT [PK_tb_fundSubFund] PRIMARY KEY CLUSTERED 
(
	[sf_id] ASC,
	[fsf_startConnection] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_historySubFund](
	[sf_id] [int] NOT NULL,
	[sf_initialDate] [datetime] NOT NULL,
	[sf_endDate] [datetime] NULL,
	[sf_officialSubFundName] [nvarchar](100) NULL,
	[sf_shortSubFundName] [nvarchar](100) NULL,
	[sf_cssfCode] [nvarchar](100) NULL,
	[sf_faCode] [nvarchar](100) NULL,
	[sf_depCode] [nvarchar](100) NULL,
	[sf_taCode] [nvarchar](100) NULL,
	[sf_firstNavDate] [datetime] NULL,
	[sf_lastNavDate] [datetime] NULL,
	[sf_cssfAuthDate] [datetime] NULL,
	[sf_expDate] [datetime] NULL,
	[sf_status] [int] NULL,
	[sf_leiCode] [nvarchar](100) NULL,
	[sf_cesrClass] [int] NULL,
	[sf_cssf_geographical_focus] [int] NULL,
	[sf_globalExposure] [int] NULL,
	[sf_currency] [nchar](3) NULL,
	[sf_navFrequency] [int] NULL,
	[sf_valutationDate] [int] NULL,
	[sf_calculationDate] [int] NULL,
	[sf_derivatives] [bit] NULL,
	[sf_derivMarket] [int] NULL,
	[sf_derivPurpose] [int] NULL,
	[sf_lastProspectus] [datetime] NULL,
	[sf_lastProspectusDate] [datetime] NULL,
	[sf_principal_asset_class] [int] NULL,
	[sf_type_of_market] [int] NULL,
	[sf_principal_investment_strategy] [int] NULL,
	[sf_clearing_code] [nvarchar](100) NULL,
	[sf_cat_morningstar] [int] NULL,
	[sf_category_six] [int] NULL,
	[sf_category_bloomberg] [int] NULL,
	[sf_change_comment] [nvarchar](max) NULL,
	[sf_comment_title] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_historySubFund] PRIMARY KEY CLUSTERED 
(
	[sf_id] ASC,
	[sf_initialDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_navFrequency](
	[nf_id] [int] NOT NULL,
	[nf_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_navFrequency] PRIMARY KEY CLUSTERED 
(
	[nf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_sf_status](
	[st_id] [int] NOT NULL,
	[st_desc] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tb_dom_sf_status] PRIMARY KEY CLUSTERED 
(
	[st_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_calculationDate](
	[cd_id] [int] NOT NULL,
	[cd_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_calculationDate] PRIMARY KEY CLUSTERED 
(
	[cd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_cesrClass](
	[cc_id] [int] NOT NULL,
	[c_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_cesrClass] PRIMARY KEY CLUSTERED 
(
	[cc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_cssf_geographical_focus](
	[gf_id] [int] NOT NULL,
	[gf_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_cssf_geographical_focus] PRIMARY KEY CLUSTERED 
(
	[gf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_cssf_principal_asset_class](
	[pac_id] [int] NOT NULL,
	[pac_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_cssf_principal_asset_class] PRIMARY KEY CLUSTERED 
(
	[pac_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_derivMarket](
	[dm_id] [int] NOT NULL,
	[dm_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_derivMarket] PRIMARY KEY CLUSTERED 
(
	[dm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_derivPurpose](
	[dp_id] [int] NOT NULL,
	[dp_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_derivPurpose] PRIMARY KEY CLUSTERED 
(
	[dp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_globalExposure](
	[ge_id] [int] NOT NULL,
	[ge_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_globalExposure] PRIMARY KEY CLUSTERED 
(
	[ge_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_principal_investment_strategy](
	[pis_id] [int] NOT NULL,
	[pis_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_principal_investment_strategy] PRIMARY KEY CLUSTERED 
(
	[pis_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_sf_cat_bloomberg](
	[cat_bloomberg_id] [int] NOT NULL,
	[cat_bloomberg_Desc] [nvarchar](100) NULL,
	[cat_bloomberg_Desc_expl] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_dom_sf_cat_bloomberg] PRIMARY KEY CLUSTERED 
(
	[cat_bloomberg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_sf_cat_morningstar](
	[c_morningstar_id] [int] NOT NULL,
	[c_morningstar_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_sf_cat_morningstar] PRIMARY KEY CLUSTERED 
(
	[c_morningstar_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_sf_cat_six](
	[cat_six_id] [int] NOT NULL,
	[cat_six_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_sf_cat_six] PRIMARY KEY CLUSTERED 
(
	[cat_six_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_type_of_market](
	[tom_id] [int] NOT NULL,
	[tom_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_type_of_market] PRIMARY KEY CLUSTERED 
(
	[tom_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_valutationDate](
	[vd_id] [int] NOT NULL,
	[vd_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_valutationDate] PRIMARY KEY CLUSTERED 
(
	[vd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_serviceAgreement_fund](
	[file_id] [int] NOT NULL,
	[file_name] [nvarchar](max) NOT NULL,
	[file_extension] [nvarchar](5) NOT NULL,
	[sa_fundId] [int] NOT NULL,
	[sa_activityType] [int] NOT NULL,
	[sa_contractDate] [datetime] NOT NULL,
	[sa_activationDate] [datetime] NOT NULL,
	[sa_expirationDate] [datetime] NULL,
	[sa_status] [int] NOT NULL,
	[sa_company] [int] NOT NULL,
 CONSTRAINT [PK__tb_serviceAgreement_fund] PRIMARY KEY CLUSTERED 
(
	[file_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_all_subfund]
(	
		@report_date date 
)
RETURNS TABLE 
AS
RETURN 
(

SELECT top(1000)

 [ID]
,[VALID FROM]
, case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL]
, [NAME]
, [STATUS]
, [CSSF CODE]
, [ADMIN CODE]
, [DEPOSITARY BANK CODE]
, [TRANSFER AGENT CODE]
, [FIRST NAV DATE]
, [LAST NAV DATE]
, [CSSF AUTH. DATE]
, [EXPIRY DATE]
,[LEI CODE]
,[CESR CLASS]
,[GEO FOCUS]
,[GLOBAL EXPOSURE]
,[CURRENCY]
,[FREQUENCY]
,[VALUATION DATE]
,[CALCULATION DATE]
,[DERIVATIVES]
,[DERIV. MARKET]
,[DERIV. PURPOSE]
,[PRINCIPAL ASSET CLASS]
,[MARKET TYPE]
,[PRINCIPAL INVESTMENT STRATEGY]
,[CLEARING CODE]
,[MORNINGSTAR CATEGORY]
,[SIX CATEGORY]
,[BLOOMBERG CATEGORY]	
FROM
(
select 

 sf_id [ID]
,convert(varchar,sf_initialDate, 103) [VALID FROM]
,convert(varchar,sf_endDate, 103) [VALID UNTIL]
,sf_officialSubFundName [NAME]
,sfstat.st_desc [STATUS]
,sf_cssfCode [CSSF CODE]
,sf_faCode [ADMIN CODE]
,sf_depCode [DEPOSITARY BANK CODE]
,sf_taCode [TRANSFER AGENT CODE]
,convert(varchar,sf_firstNavDate, 103) [FIRST NAV DATE]
,convert(varchar,sf_lastNavDate, 103) [LAST NAV DATE]
,convert(varchar,sf_cssfAuthDate, 103) [CSSF AUTH. DATE]
,convert(varchar,sf_expDate, 103) [EXPIRY DATE]
,sf_leiCode [LEI CODE]
,sfcesr.c_desc [CESR CLASS]
,sfgeo.gf_desc [GEO FOCUS]
,sfge.ge_desc [GLOBAL EXPOSURE]
,sf_currency [CURRENCY]
,nfreq.nf_desc [FREQUENCY]
,vdate.vd_desc [VALUATION DATE]
,cdate.cd_desc [CALCULATION DATE]
,case 
	when sf_derivatives=1 then 'Yes'
	when sf_derivatives=0 then 'No'
	else NULL
	END as [DERIVATIVES]
,dmar.dm_desc [DERIV. MARKET]
,dpur.dp_desc [DERIV. PURPOSE]
,pac.pac_desc [PRINCIPAL ASSET CLASS]
,tom.tom_desc [MARKET TYPE]
,pis.pis_desc [PRINCIPAL INVESTMENT STRATEGY]
,sf_clearing_code [CLEARING CODE]
,cms.c_morningstar_desc [MORNINGSTAR CATEGORY]
,cs.cat_six_desc [SIX CATEGORY]
,cb.cat_bloomberg_Desc [BLOOMBERG CATEGORY]	
	
	
	FROM tb_historySubFund sf
				left join tb_dom_sf_status sfstat on sfstat.st_id=sf.sf_status
				left join tb_dom_cesrClass sfcesr on sfcesr.cc_id=sf.sf_cesrClass
				left join tb_dom_cssf_geographical_focus sfgeo on sfgeo.gf_id=sf.sf_cssf_geographical_focus
				left join tb_dom_globalExposure sfge on sfge.ge_id=sf.sf_globalExposure
				left join tb_dom_navFrequency nfreq on nfreq.nf_id=sf.sf_navFrequency
				left join tb_dom_valutationDate vdate on vdate.vd_id=sf.sf_valutationDate
				left join tb_dom_calculationDate cdate on cdate.cd_id=sf.sf_calculationDate
				left join tb_dom_derivMarket dmar on dmar.dm_id=sf.sf_derivMarket
				left join tb_dom_derivPurpose dpur on dpur.dp_id=sf.sf_derivPurpose
				left join tb_dom_cssf_principal_asset_class pac on pac.pac_id=sf.sf_principal_asset_class
				left join tb_dom_type_of_market tom on tom.tom_id=sf.sf_type_of_market
				left join tb_dom_principal_investment_strategy pis on pis.pis_id=sf.sf_principal_investment_strategy
				left join tb_dom_sf_cat_morningstar cms on cms.c_morningstar_id=sf.sf_cat_morningstar
				left join tb_dom_sf_cat_six cs on cs.cat_six_id=sf.sf_category_six
				left join tb_dom_sf_cat_bloomberg cb on cb.cat_bloomberg_id=sf.sf_category_bloomberg


	Where (	@report_date between sf.sf_initialDate and sf.sf_endDate  OR (@report_date > sf.sf_initialDate and sf.sf_endDate is null))
) t2 
ORDER BY t2.[NAME]
) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_country_distribution_shares](
	[share_id] [int] NOT NULL,
	[iso_country_2] [nchar](2) NOT NULL,
	[local_representative] [int] NULL,
	[paying_agent] [int] NULL,
	[legal_support] [int] NULL,
	[language] [nchar](3) NOT NULL,
 CONSTRAINT [PK_tb_country_distribution_shares] PRIMARY KEY CLUSTERED 
(
	[share_id] ASC,
	[iso_country_2] ASC,
	[language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_companies](
	[c_id] [int] NOT NULL,
	[c_name] [nvarchar](max) NOT NULL,
	[c_iso3_acronym] [varchar](3) NULL,
 CONSTRAINT [PK_tb_company] PRIMARY KEY CLUSTERED 
(
	[c_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_get_share_distribution_countries]
(	
 @shareID as int
)
RETURNS TABLE 
AS
RETURN 
(
  select
		tcd.share_id,
		tcd.iso_country_2 [COUNTRY],
		tcd.[language] [LANGUAGE], 
		comLR.c_name [LOCAL REPRESENTATIVE],
		comPA.c_name [PAYING AGENT],
		comLS.c_name [LEGAL SUPPORT]
 
 from [tb_country_distribution_shares] tcd
  left  join  tb_companies comLR on comLR.c_id=tcd.local_representative
  left  join  tb_companies comPA on comPA.c_id=tcd.paying_agent
  left  join  tb_companies comLS on comLS.c_id=tcd.legal_support

  where tcd.share_id=@shareID
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_all_fund]
(	
		@report_date date 
)
RETURNS TABLE 
AS
RETURN 
(

select top(1000)
[ID],
[VALID FROM],
	case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL],
[NAME],
[STATUS],
[CSSF CODE],
[LEGAL FORM],
[LEGAL VEHICLE],
[LEGAL TYPE],
[FUND ADMIN CODE],
[DEP. CODE],
[TRANSFER AGENT CODE],
[COMPANY DESCRIPTION],
[COMPANY TYPE],
[TIN NUMBER],
[LEI CODE],
[REG. NUMBER],
[VAT REG. NUMBER],
[VAT IDENT. NUMBER],
[I.B.I.C. NUMBER]
from (

SELECT 
						convert(varchar, f.f_initial_date, 103)[VALID FROM],
			convert(varchar, f.f_end_date, 103) [VALID UNTIL],
			f.f_id [ID],
			f.f_official_fund_name [NAME],  
			f.f_cssf_code [CSSF CODE],  
			ft.st_f_desc [STATUS], 
			lf.lf_acronym [LEGAL FORM],  
			lv.lv_acronym [LEGAL VEHICLE], 
			lt.lt_acronym [LEGAL TYPE], 
			CONCAT(tb_comp_fund.c_iso3_acronym, '- ',  f_fa_code ) [FUND ADMIN CODE],
			f_dep_code [DEP. CODE],
			f_ta_code [TRANSFER AGENT CODE],
			ct.ct_desc [COMPANY DESCRIPTION],  
			CT.ct_acronym [COMPANY TYPE], 
			f.f_tin_number [TIN NUMBER], 
			f.f_lei_code [LEI CODE],
			f.f_registration_number [REG. NUMBER],
						f.f_vat_registration_number [VAT REG. NUMBER],
						f.f_vat_Identification_number [VAT IDENT. NUMBER],
						f.f_ibic_number [I.B.I.C. NUMBER]
	
	FROM tb_historyFund f
				left join tb_dom_f_status ft  on ft.st_f_id=f.f_status
				left join tb_dom_legal_form lf on lf.lf_id=f.f_legal_form
				left join tb_dom_legal_vehicle lv on lv.lv_id=f.f_legal_vehicle
				left join tb_dom_legal_type lt on lt.lt_id=f.f_legal_type
				left join tb_dom_company_type ct on ct.ct_id=f.f_company_type
					left join (select tc.c_id, tc.c_name, tc.c_iso3_acronym, sa_fundId from tb_serviceAgreement_fund saf 
								join tb_companies tc on tc.c_id=saf.sa_company
								where sa_activityType=8 
								and (@report_date >= saf.sa_activationDate and (saf.sa_expirationDate>@report_date or saf.sa_expirationDate is null) and sa_status=1)
								)tb_comp_fund  on sa_fundId=f.f_id


	Where (@report_date between f.f_initial_date and f.f_end_date  OR (@report_date >= f.f_initial_date and f.f_end_date is null))
	)tb2
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_historyShareClass](
	[sc_id] [int] NOT NULL,
	[sc_initialDate] [datetime] NOT NULL,
	[sc_endDate] [datetime] NULL,
	[sc_officialShareClassName] [nvarchar](100) NULL,
	[sc_shortShareClassName] [nvarchar](100) NULL,
	[sc_investorType] [int] NULL,
	[sc_shareType] [int] NULL,
	[sc_currency] [nchar](3) NULL,
	[sc_countryIssue] [nchar](2) NULL,
	[sc_ultimateParentCountryRisk] [nchar](2) NULL,
	[sc_emissionDate] [datetime] NULL,
	[sc_inceptionDate] [datetime] NULL,
	[sc_lastNav] [datetime] NULL,
	[sc_expiryDate] [datetime] NULL,
	[sc_status] [int] NULL,
	[sc_initialPrice] [float] NULL,
	[sc_accountingCode] [nvarchar](100) NULL,
	[sc_hedged] [bit] NULL,
	[sc_listed] [bit] NULL,
	[sc_bloomberMarket] [nvarchar](100) NULL,
	[sc_bloombedCode] [nvarchar](100) NULL,
	[sc_bloombedId] [nvarchar](100) NULL,
	[sc_isinCode] [nchar](12) NULL,
	[sc_valorCode] [nvarchar](100) NULL,
	[sc_faCode] [nvarchar](100) NULL,
	[sc_taCode] [nvarchar](100) NULL,
	[sc_WKN] [nvarchar](100) NULL,
	[sc_date_business_year] [datetime] NULL,
	[sc_prospectus_code] [nvarchar](100) NULL,
	[sc_change_comment] [nvarchar](max) NULL,
	[sc_comment_title] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_historyShareClass] PRIMARY KEY CLUSTERED 
(
	[sc_id] ASC,
	[sc_initialDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_investor_type](
	[it_id] [int] NOT NULL,
	[it_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_investor_type] PRIMARY KEY CLUSTERED 
(
	[it_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_share_status](
	[sc_s_id] [int] NOT NULL,
	[sc_s_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_share_status] PRIMARY KEY CLUSTERED 
(
	[sc_s_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_share_type](
	[st_id] [int] NOT NULL,
	[st_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_dom_share_type] PRIMARY KEY CLUSTERED 
(
	[st_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_all_shareclass]
(	
		@report_date date 
)
RETURNS TABLE 
AS
RETURN 
(

SELECT TOP(1000) 

 [ID]	
,[VALID FROM]
,case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL]
,[NAME]
,[STATUS]
,[ISIN]
,[INVESTOR TYPE]
,[SHARE TYPE]
,[CCY]
,[COUNTRY ISSUE]
,[ULT PARENT COUNTRY OF RISK]
,[EMISSION DATE]
,[INCEPTION DATE]
,[LAST NAV]
,[EXPIRY DATE]
,[INITIAL PRICE]
,[ACCOUNTING CODE]
,[HEDGED]
,[LISTED]
,[BLOOMBERG MARKET]
,[BLOOMBERG CODE]
,[BLOOMBERG ID]
,[VALOR CODE]
,[FUND ADMIN. CODE]
,[TRASFER AGENT CODE]
,[WKN CODE]
,[BUSINESS YEAR]
,[PROSPECTUS CODE]	
FROM 
( 

SELECT

 sc_id [ID]	
,convert(varchar, sc_initialDate, 103) [VALID FROM]
,convert(varchar, sc_endDate, 103) [VALID UNTIL]
,sc_officialShareClassName [NAME]
,stat.sc_s_desc [STATUS]
,intype.it_desc [INVESTOR TYPE]
,sharetype.st_desc [SHARE TYPE]
,sc_currency [CCY]
,sc_countryIssue [COUNTRY ISSUE]
,sc_ultimateParentCountryRisk [ULT PARENT COUNTRY OF RISK]
,convert(varchar, sc_emissionDate, 103) [EMISSION DATE]
,convert(varchar, sc_inceptionDate, 103) [INCEPTION DATE]
,convert(varchar, sc_lastNav, 103) [LAST NAV]
,convert(varchar, sc_expiryDate, 103) [EXPIRY DATE]
,sc_initialPrice [INITIAL PRICE]
,sc_accountingCode [ACCOUNTING CODE]
,case 
	when sc_hedged=1 then 'Yes'
	when sc_hedged=0 then 'No'
	else NULL
	END as [HEDGED]
,case 
	when sc_listed=1 then 'Yes'
	when sc_listed=0 then 'No'
	else NULL
	END as  [LISTED]
,sc_bloomberMarket [BLOOMBERG MARKET]
,sc_bloombedCode [BLOOMBERG CODE]
,sc_bloombedId [BLOOMBERG ID]
,sc_isinCode [ISIN]
,sc_valorCode [VALOR CODE]
,sc_faCode [FUND ADMIN. CODE]
,sc_taCode [TRASFER AGENT CODE]
,sc_WKN [WKN CODE]
,convert(varchar, sc_date_business_year, 103)  [BUSINESS YEAR]
,sc_prospectus_code [PROSPECTUS CODE]	
	
	FROM tb_historyShareClass sc
	left join tb_dom_investor_type intype on intype.it_id=sc.sc_investorType
	left join tb_dom_share_type sharetype on sharetype.st_id= sc.sc_shareType
	left join tb_dom_share_status stat on stat.sc_s_id=sc.sc_status
		
	Where (
		@report_date between sc.sc_initialDate and sc.sc_endDate  OR (@report_date > sc.sc_initialDate and sc.sc_endDate is null)
					 
	)
) t2
 ORDER BY t2.[NAME]
)
GO
CREATE FUNCTION [dbo].[fn_shareclass_id]
(	
		@report_date date,
				@shareclass_id as int
)
RETURNS TABLE 
AS
RETURN 
(

SELECT TOP(1) 

[ISIN CODE]
,[VALID FROM]
,case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL]
,[SHARE CLASS NAME]
,[STATUS]
,[INVESTOR TYPE]
,[SHARE TYPE]
,[CCY]
,[COUNTRY ISSUE]
,[ULT PARENT COUNTRY OF RISK]
,[EMISSION DATE]
,[INCEPTION DATE]
,[LAST NAV]
,[EXPIRY DATE]
,[INITIAL PRICE]
,[ACCOUNTING CODE]
,[HEDGED]
,[LISTED]
,[BLOOMBERG MARKET]
,[BLOOMBERG CODE]
,[BLOOMBERG ID]
,[VALOR CODE]
,[FUND ADMIN. CODE]
,[TRASFER AGENT CODE]
,[WKN CODE]
,[BUSINESS YEAR]
,[PROSPECTUS CODE]	
,[SHARE CLASS ID]
FROM 
( 

SELECT

 sc_id [SHARE CLASS ID]	
,convert(varchar, sc_initialDate, 103) [VALID FROM]
,convert(varchar, sc_endDate, 103) [VALID UNTIL]
,sc_officialShareClassName [SHARE CLASS NAME]
,stat.sc_s_desc [STATUS]
,intype.it_desc [INVESTOR TYPE]
,sharetype.st_desc [SHARE TYPE]
,sc_currency [CCY]
,sc_countryIssue [COUNTRY ISSUE]
,sc_ultimateParentCountryRisk [ULT PARENT COUNTRY OF RISK]
,convert(varchar, sc_emissionDate, 103) [EMISSION DATE]
,convert(varchar, sc_inceptionDate, 103) [INCEPTION DATE]
,convert(varchar, sc_lastNav, 103) [LAST NAV]
,convert(varchar, sc_expiryDate, 103) [EXPIRY DATE]
,sc_initialPrice [INITIAL PRICE]
,sc_accountingCode [ACCOUNTING CODE]
,case 
	when sc_hedged=1 then 'Yes'
	when sc_hedged=0 then 'No'
	else NULL
	END as [HEDGED]
,case 
	when sc_listed=1 then 'Yes'
	when sc_listed=0 then 'No'
	else NULL
	END as  [LISTED]
,sc_bloomberMarket [BLOOMBERG MARKET]
,sc_bloombedCode [BLOOMBERG CODE]
,sc_bloombedId [BLOOMBERG ID]
,sc_isinCode [ISIN CODE]
,sc_valorCode [VALOR CODE]
,sc_faCode [FUND ADMIN. CODE]
,sc_taCode [TRASFER AGENT CODE]
,sc_WKN [WKN CODE]
,convert(varchar, sc_date_business_year, 103)  [BUSINESS YEAR]
,sc_prospectus_code [PROSPECTUS CODE]	
	
	FROM tb_historyShareClass sc
	left join tb_dom_investor_type intype on intype.it_id=sc.sc_investorType
	left join tb_dom_share_type sharetype on sharetype.st_id= sc.sc_shareType
	left join tb_dom_share_status stat on stat.sc_s_id=sc.sc_status
		
	Where  (@shareclass_id = sc.sc_id) AND (
		@report_date between sc.sc_initialDate and sc.sc_endDate  OR (@report_date > sc.sc_initialDate and sc.sc_endDate is null)
					 
	)
) t2
 ORDER BY t2.[SHARE CLASS NAME]
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_activityType](
	[at_id] [int] NOT NULL,
	[at_desc] [nvarchar](100) NULL,
	[at_entity] [int] NOT NULL,
 CONSTRAINT [PK_tb_dom_activityType] PRIMARY KEY CLUSTERED 
(
	[at_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_view_agreements_all_funds]
(	
		@input_date date
)
RETURNS TABLE 
AS
RETURN 
(
select 
	   ROW_NUMBER() OVER(ORDER BY [File Description] ASC) AS [#],	
	   [File Description],
	   [Company Name],
	   [Contract Date],
	   [Activation Date],
	case 
		when [Expiration Date]>'29990101' then 'ACTIVE'
		else [Expiration Date]

	end as [Expiration Date]
	,[File Name]
		,[File Id]
	
	from 
	(
	select  
	act.at_desc [File Description],
	comp.c_name [Company Name], 
	convert(varchar, saf.sa_contractDate, 103) [Contract Date],
	convert(varchar, saf.sa_activationDate, 103) [Activation Date],
	convert(varchar, saf.sa_expirationDate, 103) [Expiration Date],
	saf.[file_name] [File Name],
		saf.[file_id] [File Id]

	from [tb_serviceAgreement_fund] saf 	
	join tb_dom_activityType act on act.at_id=saf.sa_activityType
	join tb_companies comp on comp.c_id=saf.sa_company
	)tb1
	
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_view_country_distibution_shareclass]
(		
		@id_shareclass int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
cds.share_id [ID],
cds.iso_country_2 [Country of Distribution],
cds.paying_agent [Paying Agent],
cds.legal_support [Legal Support], --
cds.language [Language]

	FROM [dbo].[tb_country_distribution_shares] cds
	
	WHERE cds.share_id=@id_shareclass
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_contract](
	[id_contract] [int] NOT NULL,
 CONSTRAINT [PK_tb_contract] PRIMARY KEY CLUSTERED 
(
	[id_contract] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_agreement_status](
	[a_s_id] [int] IDENTITY(1,1) NOT NULL,
	[a_s_desc] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tb_dom_agreement_status] PRIMARY KEY CLUSTERED 
(
	[a_s_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_entity](
	[entity_id] [int] IDENTITY(1,1) NOT NULL,
	[entity_desc] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tb_dom_entity] PRIMARY KEY CLUSTERED 
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_fee](
	[fee_id] [int] NOT NULL,
	[fee_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK__tb_dom_fee] PRIMARY KEY CLUSTERED 
(
	[fee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_fee_frequency](
	[ff_id] [int] NOT NULL,
	[ff_desc] [nvarchar](100) NULL,
 CONSTRAINT [PK__tb_dom_fee_frequency] PRIMARY KEY CLUSTERED 
(
	[ff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_fee_type](
	[ft_id] [int] NOT NULL,
	[ft_desc] [nvarchar](50) NULL,
 CONSTRAINT [PK__tb_dom_feeType] PRIMARY KEY CLUSTERED 
(
	[ft_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_file_type](
	[filetype_id] [int] IDENTITY(1,1) NOT NULL,
	[filetype_desc] [nvarchar](max) NOT NULL,
	[filetype_entity] [int] NOT NULL,
 CONSTRAINT [PK_tb_dom_file_type] PRIMARY KEY CLUSTERED 
(
	[filetype_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_iso_country](
	[iso_country_iso_2] [nchar](2) NOT NULL,
	[iso_country_desc] [nvarchar](100) NULL,
	[iso_country_3] [nchar](3) NULL,
 CONSTRAINT [PK_tb_dom_iso_country] PRIMARY KEY CLUSTERED 
(
	[iso_country_iso_2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_iso_currency](
	[iso_ccy_code] [nchar](3) NOT NULL,
	[iso_ccy_desc] [nvarchar](100) NULL,
	[iso_ccy_desc_entity] [nvarchar](100) NULL,
	[iso_ccy_numeric] [int] NULL,
 CONSTRAINT [PK_tb_dom_iso_currency] PRIMARY KEY CLUSTERED 
(
	[iso_ccy_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_dom_languages](
	[language_iso_3] [nchar](3) NOT NULL,
	[language_desc] [nvarchar](30) NULL,
 CONSTRAINT [PK_tb_dom_languages] PRIMARY KEY CLUSTERED 
(
	[language_iso_3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_fund](
	[f_id] [int] NOT NULL,
 CONSTRAINT [PK_tb_fund_1] PRIMARY KEY CLUSTERED 
(
	[f_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_historyContract](
	[id_contract] [int] NOT NULL,
	[d_initialDateContr] [datetime] NOT NULL,
	[d_endDateInvContr] [datetime] NULL,
	[s_typeContr] [nvarchar](255) NULL,
	[s_subtypeContr] [nvarchar](255) NULL,
	[id_compContractor1] [int] NOT NULL,
	[id_compContractor2] [int] NOT NULL,
	[id_compMediator] [int] NULL,
 CONSTRAINT [PK_tb_historyContract] PRIMARY KEY CLUSTERED 
(
	[id_contract] ASC,
	[d_initialDateContr] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_historyInvAccount](
	[id_invAccount] [int] NOT NULL,
	[d_initialDateInvAcc] [datetime] NOT NULL,
	[d_endDateInvAcc] [datetime] NULL,
	[id_idInvAcc] [nvarchar](100) NOT NULL,
	[s_officialNameInvAcc] [nvarchar](255) NULL,
 CONSTRAINT [PK_tb_historyInvAccount] PRIMARY KEY CLUSTERED 
(
	[id_invAccount] ASC,
	[d_initialDateInvAcc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_historyInvestor](
	[id_inv] [int] NOT NULL,
	[d_initialDateInv] [datetime] NOT NULL,
	[d_endDateInv] [datetime] NULL,
	[id_idInv] [nvarchar](100) NOT NULL,
	[s_officialNameInv] [nvarchar](255) NULL,
 CONSTRAINT [PK_tb_historyInvestor] PRIMARY KEY CLUSTERED 
(
	[id_inv] ASC,
	[d_initialDateInv] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_investor](
	[id_inv] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_inv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_investorAccount](
	[id_invAccount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_invAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_invInvAccount](
	[id_inv] [int] NOT NULL,
	[id_invAccount] [int] NOT NULL,
	[d_startConnectionInvInvAcc] [datetime] NOT NULL,
	[d_endConnectionInvInvAcc] [datetime] NULL,
 CONSTRAINT [PK_tb_invInvAccount] PRIMARY KEY CLUSTERED 
(
	[id_invAccount] ASC,
	[id_inv] ASC,
	[d_startConnectionInvInvAcc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_invInvAccShareClass](
	[id_inv] [int] NOT NULL,
	[id_invAccount] [int] NOT NULL,
	[id_shareClass] [int] NOT NULL,
	[d_startConnectionInvInvAcc] [datetime] NOT NULL,
	[d_endConnectionInvInvAcc] [datetime] NULL,
 CONSTRAINT [PK_tb_invInvAccShareClass] PRIMARY KEY CLUSTERED 
(
	[id_invAccount] ASC,
	[id_inv] ASC,
	[id_shareClass] ASC,
	[d_startConnectionInvInvAcc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_shareClass](
	[id_sc] [int] NOT NULL,
 CONSTRAINT [PK_tb_shareClass_1] PRIMARY KEY CLUSTERED 
(
	[id_sc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_subFund](
	[id_subFund] [int] NOT NULL,
 CONSTRAINT [PK_tb_subFund_1] PRIMARY KEY CLUSTERED 
(
	[id_subFund] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[tb_companies] ([c_id], [c_name], [c_iso3_acronym]) VALUES (1, N'Pharus Management Lux SA', N'PML')
INSERT [dbo].[tb_companies] ([c_id], [c_name], [c_iso3_acronym]) VALUES (2, N'Edmond de Rothschild Asset Management (Luxembourg)', N'EDR')
INSERT [dbo].[tb_companies] ([c_id], [c_name], [c_iso3_acronym]) VALUES (3, N'UBS Fund Services (Luxembourg) S.A.', N'UBS')
INSERT [dbo].[tb_companies] ([c_id], [c_name], [c_iso3_acronym]) VALUES (4, N'CACEIS Bank Luxembourg', N'CAC')
INSERT [dbo].[tb_companies] ([c_id], [c_name], [c_iso3_acronym]) VALUES (5, N'Northern Trust Global Services SE', N'NTS')
GO
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (94, N'IT', NULL, NULL, NULL, N'ITA')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (94, N'LU', NULL, NULL, NULL, N'ENG')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (95, N'IT', NULL, NULL, NULL, N'ITA')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (95, N'LU', NULL, NULL, NULL, N'ENG')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (160, N'IT', NULL, NULL, NULL, N'ITA')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (160, N'LU', NULL, NULL, NULL, N'ENG')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (164, N'IT', NULL, NULL, NULL, N'ITA')
INSERT [dbo].[tb_country_distribution_shares] ([share_id], [iso_country_2], [local_representative], [paying_agent], [legal_support], [language]) VALUES (164, N'LU', NULL, NULL, NULL, N'ENG')
GO
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (1, N'Management Company Agreement', 1)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (2, N'Investment Management Agreement', 2)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (3, N'Distribution Agreeement', 3)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (4, N'ISDA', 2)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (5, N'Giveup Agreement', 2)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (6, N'Hedging Contract', 3)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (7, N'Credit Facility And Collateral Agreement', 1)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (8, N'Central Administration Agreement', 1)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (9, N'Depositary Bank Agreement', 1)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (10, N'Investment Advisory Agreement', 2)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (11, N'Introducer', 3)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (12, N'EMIR', 2)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (13, N'Fiduciary Deposit Framework Agreement', 1)
INSERT [dbo].[tb_dom_activityType] ([at_id], [at_desc], [at_entity]) VALUES (14, N'Private Placement Agreement', 3)
GO
SET IDENTITY_INSERT [dbo].[tb_dom_agreement_status] ON 

INSERT [dbo].[tb_dom_agreement_status] ([a_s_id], [a_s_desc]) VALUES (1, N'Active')
INSERT [dbo].[tb_dom_agreement_status] ([a_s_id], [a_s_desc]) VALUES (2, N'Inactive')
SET IDENTITY_INSERT [dbo].[tb_dom_agreement_status] OFF
GO
INSERT [dbo].[tb_dom_calculationDate] ([cd_id], [cd_desc]) VALUES (1, N'Prior')
INSERT [dbo].[tb_dom_calculationDate] ([cd_id], [cd_desc]) VALUES (2, N'Current')
GO
INSERT [dbo].[tb_dom_cesrClass] ([cc_id], [c_desc]) VALUES (1, N'Market Fund')
INSERT [dbo].[tb_dom_cesrClass] ([cc_id], [c_desc]) VALUES (2, N'Absolute Return')
INSERT [dbo].[tb_dom_cesrClass] ([cc_id], [c_desc]) VALUES (3, N'Total Return')
INSERT [dbo].[tb_dom_cesrClass] ([cc_id], [c_desc]) VALUES (4, N'Lyfe Cycle Fund')
INSERT [dbo].[tb_dom_cesrClass] ([cc_id], [c_desc]) VALUES (5, N'Structured Fund')
GO
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (1, N'Public limited company', N'S.A.')
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (2, N'European company', N'S.E.')
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (3, N'Private limited liability company', N'S.à r.l.')
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (4, N'Partnership limited by shares', N'S.C.A.')
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (5, N'Special limited partnership', N'S.C.Sp.')
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (6, N'Limited partnership', N'S.C.S.')
INSERT [dbo].[tb_dom_company_type] ([ct_id], [ct_desc], [ct_acronym]) VALUES (7, N'Cooperative company organized as a public limited company', N'S.Co S.A.')
GO
INSERT [dbo].[tb_dom_cssf_geographical_focus] ([gf_id], [gf_desc]) VALUES (1, N'Africa')
INSERT [dbo].[tb_dom_cssf_geographical_focus] ([gf_id], [gf_desc]) VALUES (2, N'Asia & Pacific')
INSERT [dbo].[tb_dom_cssf_geographical_focus] ([gf_id], [gf_desc]) VALUES (3, N'Europe')
INSERT [dbo].[tb_dom_cssf_geographical_focus] ([gf_id], [gf_desc]) VALUES (4, N'North America')
INSERT [dbo].[tb_dom_cssf_geographical_focus] ([gf_id], [gf_desc]) VALUES (5, N'Central and South America')
INSERT [dbo].[tb_dom_cssf_geographical_focus] ([gf_id], [gf_desc]) VALUES (6, N'Multiple Regions')
GO
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (1, N'Equity')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (2, N'IG Bond')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (3, N'HY Bond')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (4, N'General Bond')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (5, N'Convertible Bond')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (6, N'MM instruments')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (7, N'ABS/MBS')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (8, N'Foreign Exchange')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (9, N'Commodities')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (10, N'Volatility')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (11, N'Mixed Bond/Equity')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (12, N'Mixed others')
INSERT [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id], [pac_desc]) VALUES (13, N'Others')
GO
INSERT [dbo].[tb_dom_derivMarket] ([dm_id], [dm_desc]) VALUES (1, N'OTC')
INSERT [dbo].[tb_dom_derivMarket] ([dm_id], [dm_desc]) VALUES (2, N'Listed')
INSERT [dbo].[tb_dom_derivMarket] ([dm_id], [dm_desc]) VALUES (3, N'Both')
GO
INSERT [dbo].[tb_dom_derivPurpose] ([dp_id], [dp_desc]) VALUES (1, N'Hedging')
INSERT [dbo].[tb_dom_derivPurpose] ([dp_id], [dp_desc]) VALUES (2, N'Speculation')
INSERT [dbo].[tb_dom_derivPurpose] ([dp_id], [dp_desc]) VALUES (3, N'Both')
GO
SET IDENTITY_INSERT [dbo].[tb_dom_entity] ON 

INSERT [dbo].[tb_dom_entity] ([entity_id], [entity_desc]) VALUES (1, N'Fund')
INSERT [dbo].[tb_dom_entity] ([entity_id], [entity_desc]) VALUES (2, N'Subfund')
INSERT [dbo].[tb_dom_entity] ([entity_id], [entity_desc]) VALUES (3, N'Shareclass')
SET IDENTITY_INSERT [dbo].[tb_dom_entity] OFF
GO
INSERT [dbo].[tb_dom_f_status] ([st_f_id], [st_f_desc]) VALUES (1, N'Active')
INSERT [dbo].[tb_dom_f_status] ([st_f_id], [st_f_desc]) VALUES (2, N'Inactive - Liquidated')
INSERT [dbo].[tb_dom_f_status] ([st_f_id], [st_f_desc]) VALUES (3, N'Inactive - Closed')
INSERT [dbo].[tb_dom_f_status] ([st_f_id], [st_f_desc]) VALUES (4, N'Inactive - To be launched')
INSERT [dbo].[tb_dom_f_status] ([st_f_id], [st_f_desc]) VALUES (5, N'Inactive - Merged')
GO
INSERT [dbo].[tb_dom_fee] ([fee_id], [fee_desc]) VALUES (1, N'Risk')
INSERT [dbo].[tb_dom_fee] ([fee_id], [fee_desc]) VALUES (2, N'Management Company')
GO
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (1, N'Daily')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (2, N'Weekly')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (3, N'Weekly and last Monthly nav')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (4, N'Monthly ')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (5, N'Fortnightly')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (6, N'Fortnightly and last Monthly nav')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (7, N'Quarterly')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (8, N'Semi-annually')
INSERT [dbo].[tb_dom_fee_frequency] ([ff_id], [ff_desc]) VALUES (9, N'Annually')
GO
INSERT [dbo].[tb_dom_fee_type] ([ft_id], [ft_desc]) VALUES (1, N'Fixed Amount')
INSERT [dbo].[tb_dom_fee_type] ([ft_id], [ft_desc]) VALUES (2, N'% AuM')
GO
SET IDENTITY_INSERT [dbo].[tb_dom_file_type] ON 

INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (2, N'Prospectus', 1)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (3, N'KIID - ENG', 3)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (4, N'Pricing Policy', 1)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (5, N'Official NAV Report', 2)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (6, N'KIID - IT', 3)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (7, N'KIID - DE', 3)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (8, N'KIID - FR', 3)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (9, N'KIID - IT/CH', 3)
INSERT [dbo].[tb_dom_file_type] ([filetype_id], [filetype_desc], [filetype_entity]) VALUES (10, N'Circular Resolution - Prospectus changes', 1)
SET IDENTITY_INSERT [dbo].[tb_dom_file_type] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_dom_fund_admin_type] ON 

INSERT [dbo].[tb_dom_fund_admin_type] ([fat_id], [fat_desc], [fat_acronym]) VALUES (1, N'CACEIS', N'CAC  ')
INSERT [dbo].[tb_dom_fund_admin_type] ([fat_id], [fat_desc], [fat_acronym]) VALUES (2, N'Northern Trust', N'UBS  ')
INSERT [dbo].[tb_dom_fund_admin_type] ([fat_id], [fat_desc], [fat_acronym]) VALUES (3, N'Edmond de Rothschild', N'ROT  ')
SET IDENTITY_INSERT [dbo].[tb_dom_fund_admin_type] OFF
GO
INSERT [dbo].[tb_dom_globalExposure] ([ge_id], [ge_desc]) VALUES (1, N'VaR Absolute')
INSERT [dbo].[tb_dom_globalExposure] ([ge_id], [ge_desc]) VALUES (2, N'Var Relative')
INSERT [dbo].[tb_dom_globalExposure] ([ge_id], [ge_desc]) VALUES (3, N'Commitment')
INSERT [dbo].[tb_dom_globalExposure] ([ge_id], [ge_desc]) VALUES (4, N'AIF Gross Net')
GO
INSERT [dbo].[tb_dom_investor_type] ([it_id], [it_desc]) VALUES (1, N'Retail')
INSERT [dbo].[tb_dom_investor_type] ([it_id], [it_desc]) VALUES (2, N'Qualified')
INSERT [dbo].[tb_dom_investor_type] ([it_id], [it_desc]) VALUES (3, N'Professional')
INSERT [dbo].[tb_dom_investor_type] ([it_id], [it_desc]) VALUES (4, N'Institutional')
INSERT [dbo].[tb_dom_investor_type] ([it_id], [it_desc]) VALUES (5, N'Well Informed')
INSERT [dbo].[tb_dom_investor_type] ([it_id], [it_desc]) VALUES (6, N'Reserved')
GO
INSERT [dbo].[tb_dom_iso_country] ([iso_country_iso_2], [iso_country_desc], [iso_country_3]) VALUES (N'IT', N'ITALY                                                                                               ', N'ITA')
INSERT [dbo].[tb_dom_iso_country] ([iso_country_iso_2], [iso_country_desc], [iso_country_3]) VALUES (N'LU', N'LUXEMBOURG                                                                                          ', N'ZWE')
GO

INSERT [dbo].[tb_dom_iso_currency] ([iso_ccy_code], [iso_ccy_desc], [iso_ccy_desc_entity], [iso_ccy_numeric]) VALUES (N'EUR', N'Euro                                                                                                ', N'EUROPEAN MONETARY UNION                                                                             ', 978)
INSERT [dbo].[tb_dom_iso_currency] ([iso_ccy_code], [iso_ccy_desc], [iso_ccy_desc_entity], [iso_ccy_numeric]) VALUES (N'USD', N'US Dollar                                                                                           ', N'UNITED STATES                                                                                       ', 840)

GO
INSERT [dbo].[tb_dom_languages] ([language_iso_3], [language_desc]) VALUES (N'DEU', N'German')
INSERT [dbo].[tb_dom_languages] ([language_iso_3], [language_desc]) VALUES (N'ENG', N'English')
INSERT [dbo].[tb_dom_languages] ([language_iso_3], [language_desc]) VALUES (N'FRA', N'French')
INSERT [dbo].[tb_dom_languages] ([language_iso_3], [language_desc]) VALUES (N'ITA', N'Italian')
INSERT [dbo].[tb_dom_languages] ([language_iso_3], [language_desc]) VALUES (N'SPA', N'Spanish')
GO
INSERT [dbo].[tb_dom_legal_form] ([lf_id], [lf_acronym]) VALUES (1, N'FCP')
INSERT [dbo].[tb_dom_legal_form] ([lf_id], [lf_acronym]) VALUES (2, N'SICAV')
INSERT [dbo].[tb_dom_legal_form] ([lf_id], [lf_acronym]) VALUES (3, N'SICAF')
GO
INSERT [dbo].[tb_dom_legal_type] ([lt_id], [lt_acronym]) VALUES (1, N'UCITS')
INSERT [dbo].[tb_dom_legal_type] ([lt_id], [lt_acronym]) VALUES (2, N'AIF')
INSERT [dbo].[tb_dom_legal_type] ([lt_id], [lt_acronym]) VALUES (3, N'OTHERS')
GO
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (1, N'UCITS', 1)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (2, N'SIF', 2)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (3, N'UCI - Part II', 2)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (4, N'RAIF', 2)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (5, N'SICAR', 2)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (6, N'SOPARFI', 3)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (7, N'SPF', 3)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (8, N'SV', 3)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (9, N'ELTIF', 2)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (10, N'EUVECA', 2)
INSERT [dbo].[tb_dom_legal_vehicle] ([lv_id], [lv_acronym], [lv_fk_legal_type]) VALUES (11, N'EUSEF', 2)
GO
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (1, N'Daily')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (2, N'Weekly')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (3, N'Weekly and last Monthly nav')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (4, N'Monthly')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (5, N'Fortnightly')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (6, N'Fortnightly and last Monthly nav')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (7, N'Quarterly')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (8, N'Semi-annually')
INSERT [dbo].[tb_dom_navFrequency] ([nf_id], [nf_desc]) VALUES (9, N'Annually')
GO
INSERT [dbo].[tb_dom_principal_investment_strategy] ([pis_id], [pis_desc]) VALUES (1, N'Long                                                                                                ')
INSERT [dbo].[tb_dom_principal_investment_strategy] ([pis_id], [pis_desc]) VALUES (2, N'Short                                                                                               ')
INSERT [dbo].[tb_dom_principal_investment_strategy] ([pis_id], [pis_desc]) VALUES (3, N'Long Short                                                                                          ')
INSERT [dbo].[tb_dom_principal_investment_strategy] ([pis_id], [pis_desc]) VALUES (4, N'Market Neutral                                                                                      ')
INSERT [dbo].[tb_dom_principal_investment_strategy] ([pis_id], [pis_desc]) VALUES (5, N'Arbitrage                                                                                           ')
INSERT [dbo].[tb_dom_principal_investment_strategy] ([pis_id], [pis_desc]) VALUES (6, N'Unconstrained/ Multistrategy                                                                        ')
GO
INSERT [dbo].[tb_dom_sf_status] ([st_id], [st_desc]) VALUES (1, N'Active')
INSERT [dbo].[tb_dom_sf_status] ([st_id], [st_desc]) VALUES (2, N'Inactive - Liquidated')
INSERT [dbo].[tb_dom_sf_status] ([st_id], [st_desc]) VALUES (3, N'Inactive - Closed')
INSERT [dbo].[tb_dom_sf_status] ([st_id], [st_desc]) VALUES (4, N'Inactive - To be launched')
INSERT [dbo].[tb_dom_sf_status] ([st_id], [st_desc]) VALUES (5, N'Inactive - Merged')
GO
INSERT [dbo].[tb_dom_share_status] ([sc_s_id], [sc_s_desc]) VALUES (1, N'Active')
INSERT [dbo].[tb_dom_share_status] ([sc_s_id], [sc_s_desc]) VALUES (2, N'Inactive - Liquidated')
INSERT [dbo].[tb_dom_share_status] ([sc_s_id], [sc_s_desc]) VALUES (3, N'Inactive - Closed')
INSERT [dbo].[tb_dom_share_status] ([sc_s_id], [sc_s_desc]) VALUES (4, N'Inactive - To be launched')
INSERT [dbo].[tb_dom_share_status] ([sc_s_id], [sc_s_desc]) VALUES (5, N'Inactive - Merged')
GO
INSERT [dbo].[tb_dom_share_type] ([st_id], [st_desc]) VALUES (1, N'Accumulation                                                                                        ')
INSERT [dbo].[tb_dom_share_type] ([st_id], [st_desc]) VALUES (2, N'Distribution                                                                                        ')
GO
INSERT [dbo].[tb_dom_type_of_market] ([tom_id], [tom_desc]) VALUES (1, N'Developed                                                                                           ')
INSERT [dbo].[tb_dom_type_of_market] ([tom_id], [tom_desc]) VALUES (2, N'Emerging                                                                                            ')
INSERT [dbo].[tb_dom_type_of_market] ([tom_id], [tom_desc]) VALUES (3, N'Mixed                                                                                               ')
GO
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (1, N'Monday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (2, N'Tuesday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (3, N'Wednesday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (4, N'Thursday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (5, N'Friday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (6, N'Saturday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (7, N'Sunday')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (8, N'Last business day of the month')
INSERT [dbo].[tb_dom_valutationDate] ([vd_id], [vd_desc]) VALUES (9, N'Today')
GO
INSERT [dbo].[tb_fund] ([f_id]) VALUES (1)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (2)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (3)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (4)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (5)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (6)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (7)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (8)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (9)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (10)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (11)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (12)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (13)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (14)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (15)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (16)
INSERT [dbo].[tb_fund] ([f_id]) VALUES (17)
GO
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (1, CAST(N'2002-12-05T00:00:00.000' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), 1, N'B90212', N'PHARUS SICAV', N'PHARUS SICAV', N'222100JG4N94G0JFHL87', N'O00003465', N'3465', N'3465', N'3465', 2, 1, 1, 1, N'2002 4500 919', N'Launch of new Sub Funds', N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (1, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-06-17T00:00:00.000' AS DateTime), 1, N'B90212', N'PHARUS SICAV', N'PHARUS SICAV', N'222100JG4N94G0JFHL87', N'O00003465', N'3465', N'3465', N'3465', 2, 1, 1, 1, N'2002 4500 919', NULL, N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (1, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), 1, N'B90212', N'PHARUS SICAV', N'PHARUS SICAV', N'222100JG4N94G0JFHL87', N'O00003465', N'3465', N'3465', N'3465', 2, 1, 1, 1, N'2002 4500 919', NULL, N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (1, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), 1, N'B90212', N'PHARUS SICAV', N'PHARUS SICAV', N'222100JG4N94G0JFHL87', N'O00003465', N'3465', N'3465', N'3465', 2, 1, 1, 1, N'2002 4500 919', N'Main changes New subfunds (Flexible Alocation, Basic Fund, Galileo Dynamic) Chnage of name (Biotech in MEdicall Innovation, Absolute Return in Conservative)Bond Value and Global Dynamic opportunities placed into dormant list). Target changed invest policy.', N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (1, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, 1, N'B90212', N'PHARUS SICAV', N'PHARUS SICAV', N'222100JG4N94G0JFHL87', N'O00003465', N'3465', N'3465', N'3465', 2, 1, 1, 1, N'2002 4500 919', N'Main changes New subfunds (Flexible Alocation, Basic Fund, Galileo Dynamic) Chnage of name (Biotech in MEdicall Innovation, Absolute Return in Conservative)Bond Value and Global Dynamic opportunities placed into dormant list). Target changed invest policy.', N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (2, CAST(N'2012-08-20T00:00:00.000' AS DateTime), CAST(N'2019-07-10T00:00:00.000' AS DateTime), 1, N'B177997', N'MULTI STARS SICAV', N'MULTI STARS SICAV', N'529900W4LEFLCLOP5984', N'O00007588', N'7588', N'7588', N'7588', 2, 1, 1, 1, N'2012 4501 262', NULL, N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (2, CAST(N'2019-07-11T00:00:00.000' AS DateTime), CAST(N'2019-11-14T00:00:00.000' AS DateTime), 1, N'B177997', N'MULTI STARS SICAV', N'MULTI STARS SICAV', N'529900W4LEFLCLOP5984', N'O00007588', N'7588', N'7588', N'7588', 2, 1, 1, 1, N'2012 4501 262', NULL, N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (2, CAST(N'2019-11-15T00:00:00.000' AS DateTime), CAST(N'2019-12-10T00:00:00.000' AS DateTime), 1, N'B177997', N'MULTI STARS SICAV', N'MULTI STARS SICAV', N'529900W4LEFLCLOP5984', N'O00007588', N'7588', N'7588', N'7588', 2, 1, 1, 1, N'2012 4501 262', NULL, N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (2, CAST(N'2019-12-11T00:00:00.000' AS DateTime), CAST(N'2019-12-31T00:00:00.000' AS DateTime), 1, N'B177997', N'MULTI STARS SICAV', N'MULTI STARS SICAV', N'529900W4LEFLCLOP5984', N'O00007588', N'7588', N'7588', N'7588', 2, 1, 1, 1, N'2012 4501 262', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (2, CAST(N'2020-01-01T00:00:00.000' AS DateTime), CAST(N'2020-09-17T00:00:00.000' AS DateTime), 1, N'B177997', N'MULTI STARS SICAV', N'MULTI STARS SICAV', N'529900W4LEFLCLOP5984', N'O00007588', N'7588', N'7588', N'7588', 2, 1, 1, 1, N'2012 4501 262', N'Emerging Market Local Currency	49% residual should include bond not emerging markets, Cube	clarify the payments of perfomance fees to the sharholders of class Z, Hearth Ethical	Class D should become hedged class, Hearth Ethical	Class F should become hedged class, Hearth Ethical	Update of invesment manager name from Valeur to Valori, Hearth Ethical	% of invetsments in UCITS/UCIs should be lowered from 50% - 10%, Alexander	delete typo on valuation date , Regent	incl valuation date, Regent	incl pos', N'CHANGE OF PROSPECTUS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (2, CAST(N'2020-09-18T00:00:00.000' AS DateTime), NULL, 1, N'B177997', N'MULTI STARS SICAV', N'MULTI STARS SICAV', N'529900W4LEFLCLOP5984', N'O00007588', N'7588', N'7588', N'7588', 2, 1, 1, 1, N'2012 4501 262', N'Emerging Market Local Currency	49% residual should include bond not emerging markets, Cube	clarify the payments of perfomance fees to the sharholders of class Z, Hearth Ethical	Class D should become hedged class, Hearth Ethical	Class F should become hedged class, Hearth Ethical	Update of invesment manager name from Valeur to Valori, Hearth Ethical	% of invetsments in UCITS/UCIs should be lowered from 50% - 10%, Alexander	delete typo on valuation date , Regent	incl valuation date, Regent	incl pos', N'CHANGE OF PROSPECTUS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (3, CAST(N'2018-11-29T00:00:00.000' AS DateTime), CAST(N'2020-10-01T00:00:00.000' AS DateTime), 1, N'O00007630', N'KITE FUND SICAV', N'KITE FUND SICAV', N'529900B4ZMG7YZ2DLQ49', N'O00007630', N'7630', N'7630', N'7630', 2, 1, 1, 1, N'2012 45 01 599', N'New shares, amendment of fees, change auditor, update list of directors', N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (3, CAST(N'2020-10-02T00:00:00.000' AS DateTime), NULL, 1, N'O00007630', N'KITE FUND SICAV', N'KITE FUND SICAV', N'529900B4ZMG7YZ2DLQ49', N'O00007630', N'7630', N'7630', N'7630', 2, 1, 1, 1, N'2012 45 01 599', N'New shares, amendment of fees, change auditor, update list of directors', N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (4, CAST(N'2015-12-17T00:00:00.000' AS DateTime), CAST(N'2020-09-03T00:00:00.000' AS DateTime), 1, N'B203047', N'EMERALD SICAV', N'EMERALD SICAV', N'Never requested', N'O00008724', N'8724', N'8724', N'8724', 2, 1, 1, 1, N'2015 4502 093', N'Launch of Emerald Euro Governement Bond', N'LAUNCH OF 1 NEW SUBFUND', NULL, NULL, NULL, 1)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (4, CAST(N'2020-09-04T00:00:00.000' AS DateTime), NULL, 1, N'B203047', N'EMERALD SICAV', N'EMERALD SICAV', N'Never requested', N'O00008724', N'8724', N'8724', N'8724', 2, 1, 1, 1, N'2015 4502 093', N'Launch of Emerald Euro Governement Bond', N'LAUNCH OF 1 NEW SUBFUND', NULL, NULL, NULL, 1)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (5, CAST(N'1997-01-01T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), 1, N'O00002118', N'EFFICIENCY GROWTH FUND', N'EFFICIENCY GROWTH FUND', N'5299001XQ85TQ8T4AV09', N'O00002118', N'2118', N'2118', N'2118', 2, 1, 1, 1, N'1997 4500 674', NULL, N'CHANGED NAME OF FUND', NULL, NULL, NULL, 1)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (5, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, 1, N'O00002118', N'GFG FUNDS', N'GFG FUNDS', N'5299001XQ85TQ8T4AV09', N'O00002118', N'2118', N'2118', N'2118', 2, 1, 1, 1, N'1997 4500 674', NULL, N'CHANGED NAME OF FUND', NULL, NULL, NULL, 1)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (6, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2019-06-27T00:00:00.000' AS DateTime), 1, N'B212389', N'BRIGHT STARS SICAV-SIF', N'BRIGHT STARS SICAV-SIF', N'Never requested', N'O00011020', N'11020', N'11020', N'11020', 2, 2, 2, 1, N'2017 4500 151', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (6, CAST(N'2019-06-28T00:00:00.000' AS DateTime), NULL, 1, N'B212389', N'BRIGHT STARS SICAV-SIF', N'BRIGHT STARS SICAV-SIF', N'Never requested', N'O00011020', N'11020', N'11020', N'11020', 2, 2, 2, 1, N'2017 4500 151', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (7, CAST(N'2017-05-05T00:00:00.000' AS DateTime), CAST(N'2019-09-15T00:00:00.000' AS DateTime), 1, N'B213151', N'1ST SICAV', N'1ST SICAV', N'549300WTGS4L8JZYP719', N'O00011081', N'11081', N'11081', N'11081', 2, 1, 1, 1, N'2017 4500 283', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (7, CAST(N'2019-09-16T00:00:00.000' AS DateTime), NULL, 1, N'B213151', N'1ST SICAV', N'1ST SICAV', N'549300WTGS4L8JZYP719', N'O00011081', N'11081', N'11081', N'11081', 2, 1, 1, 1, N'2017 4500 283', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (8, CAST(N'2017-07-19T00:00:00.000' AS DateTime), CAST(N'2019-12-01T00:00:00.000' AS DateTime), 1, N'B216631', N'RITOM SICAV-RAIF', N'RITOM SICAV-RAIF', N'529900QN7IEME9MI2J78', N'V00001829', N'1829', N'1829', N'1829', 2, 2, 4, 1, N'2017 2207 554', NULL, N'LAUNCH OF NEW SUB FUNDS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (8, CAST(N'2019-12-02T00:00:00.000' AS DateTime), CAST(N'2020-03-31T00:00:00.000' AS DateTime), 1, N'B216631', N'RITOM SICAV-RAIF', N'RITOM SICAV-RAIF', N'529900QN7IEME9MI2J78', N'V00001829', N'1829', N'1829', N'1829', 2, 2, 4, 1, N'2017 2207 554', NULL, N'NEW PROSPECTUS ', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (8, CAST(N'2020-04-01T00:00:00.000' AS DateTime), NULL, 1, N'B216631', N'RITOM SICAV-RAIF', N'RITOM SICAV-RAIF', N'529900QN7IEME9MI2J78', N'V00001829', N'1829', N'1829', N'1829', 2, 2, 4, 1, N'2017 2207 554', NULL, N'NEW PROSPECTUS ', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (9, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, 4, N'B166082', N'SWISSNESS', N'SWISSNESS', N'Never requested', N'O00003553', N'3553', N'3553', N'3553', 2, 1, 1, 1, N'2011 4503 186', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (10, CAST(N'2018-08-28T00:00:00.000' AS DateTime), NULL, 1, N'B175600', N'SWAN SICAV-SIF', N'SWAN SICAV-SIF', N'529900H6INIJHLCW4R96', N'O00007843', N'7843', N'7843', N'7843', 2, 2, 2, 1, N'2013 4500 329', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (11, CAST(N'2003-07-31T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), 1, N'O00003599', N'TIMEO NEUTRAL SICAV', N'TIMEO NEUTRAL SICAV', N'529900II6NUSUF43EY69', N'O00003599', N'3599', N'3599', N'3599', 2, 1, 1, 1, N'2003 4500 445', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 1)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (11, CAST(N'2019-06-01T00:00:00.000' AS DateTime), NULL, 1, N'O00003599', N'TIMEO NEUTRAL SICAV', N'TIMEO NEUTRAL SICAV', N'529900II6NUSUF43EY69', N'O00003599', N'3599', N'3599', N'3599', 2, 1, 1, 1, N'2003 4500 445', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 1)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (12, CAST(N'2018-03-12T00:00:00.000' AS DateTime), CAST(N'2019-08-20T00:00:00.000' AS DateTime), 1, N'B222856', N'UNITED SICAV-RAIF', N'UNITED SICAV-RAIF', N'54930084108B8S6V7E17', N'V00001957', N'1957', N'1957', N'1957', 2, 2, 4, 1, N'2018 4500 583', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (12, CAST(N'2019-08-21T00:00:00.000' AS DateTime), NULL, 1, N'B222856', N'UNITED SICAV-RAIF', N'UNITED SICAV-RAIF', N'54930084108B8S6V7E17', N'V00001957', N'1957', N'1957', N'1957', 2, 2, 4, 1, N'2018 4500 583', NULL, N'NEW PROSPECTUS', NULL, NULL, NULL, 3)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (15, CAST(N'2020-08-28T00:00:00.000' AS DateTime), NULL, 1, NULL, N'MH FUND SA SICAV-SIF', N'MH FUND SA SICAV-SIF', NULL, N'O00008878', N'LU8251', N'LU8251', N'LU8251', 2, 2, 2, 1, N'2016 4501 370', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (16, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2019-08-30T00:00:00.000' AS DateTime), 1, NULL, N'SIFTER FUND', N'SIFTER FUND', N'EVK05KS7XY1DEII3R011', N'O00003553', N'38001F', N'38001F', N'38001F', 2, 1, 1, 1, NULL, N'Sifter fund migrated to ADEPA ManCo', N'CHANGE MANCO', NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historyFund] ([f_id], [f_initial_date], [f_end_date], [f_status], [f_registration_number], [f_official_fund_name], [f_short_fund_name], [f_lei_code], [f_cssf_code], [f_fa_code], [f_dep_code], [f_ta_code], [f_legal_form], [f_legal_type], [f_legal_vehicle], [f_company_type], [f_tin_number], [f_change_comment], [f_comment_title], [f_vat_registration_number], [f_vat_identification_number], [f_ibic_number], [f_fund_admin]) VALUES (16, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, 3, NULL, N'SIFTER FUND', N'SIFTER FUND', N'EVK05KS7XY1DEII3R011', N'O00003553', N'38001F', N'38001F', N'38001F', 2, 1, 1, 1, NULL, N'Sifter fund migrated to ADEPA ManCo', N'CHANGE MANCO', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (1, CAST(N'2011-07-14T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Euro Global Bond I EUR', N'Efficiency Growth Fund - Euro Global Bond I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2012-12-31T00:00:00.000' AS DateTime), CAST(N'2012-12-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, N'EFFEGIE LX', NULL, N'LU0828733419', NULL, N'51115', NULL, N'A12FXJ', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (1, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond I EUR', N'GFG Funds Euro Global Bond I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2012-12-31T00:00:00.000' AS DateTime), CAST(N'2012-12-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, N'EFFEGIE LX', NULL, N'LU0828733419', NULL, N'51115', NULL, N'A12FXJ', NULL, N'I', NULL, N'SHARE CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (2, CAST(N'2011-07-14T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Euro Global Bond P EUR', N'Efficiency Growth Fund - Euro Global Bond P EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2011-07-14T00:00:00.000' AS DateTime), CAST(N'2011-07-14T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, N'EFFEGBB LX', NULL, N'LU0622616760', N'12909862', N'51115', NULL, N'A1JG8V', NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (2, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond P EUR', N'GFG Funds Euro Global Bond P EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2011-07-14T00:00:00.000' AS DateTime), CAST(N'2011-07-14T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, N'EFFEGBB LX', NULL, N'LU0622616760', N'12909862', N'51115', NULL, N'A1JG8V', NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (3, CAST(N'2014-09-26T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Euro Global Bond PP EUR', N'Efficiency Growth Fund - Euro Global Bond PP EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-09-26T00:00:00.000' AS DateTime), CAST(N'2014-09-26T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1095075120', N'25029901', N'51115', NULL, N'A12FXK', NULL, N'PP', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (3, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond PP EUR', N'GFG Funds Euro Global Bond PP EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-09-26T00:00:00.000' AS DateTime), CAST(N'2014-09-26T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1095075120', N'25029901', N'51115', NULL, N'A12FXK', NULL, N'PP', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (4, CAST(N'2015-03-26T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond P CHF', N'GFG Funds Euro Global Bond P CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2015-03-26T00:00:00.000' AS DateTime), CAST(N'2015-03-26T00:00:00.000' AS DateTime), NULL, NULL, 4, 100, N'C7', 1, 0, NULL, NULL, NULL, N'LU1196450263', NULL, N'51115', NULL, NULL, NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (5, CAST(N'2014-11-21T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond P USD', N'GFG Funds Euro Global Bond P USD', 1, 1, N'USD', NULL, NULL, CAST(N'2014-11-21T00:00:00.000' AS DateTime), CAST(N'2014-11-21T00:00:00.000' AS DateTime), NULL, NULL, 4, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1138304412', NULL, N'51115', NULL, NULL, NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (6, CAST(N'2014-11-27T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond PP USD', N'GFG Funds Euro Global Bond PP USD', 1, 1, N'USD', NULL, NULL, CAST(N'2014-11-27T00:00:00.000' AS DateTime), CAST(N'2014-11-27T00:00:00.000' AS DateTime), NULL, NULL, 4, 100, N'C5', 1, 0, NULL, NULL, NULL, N'LU1138304768', NULL, N'51115', NULL, NULL, NULL, N'PP', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (7, CAST(N'2015-10-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond Q EUR', N'GFG Funds Euro Global Bond Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-10-13T00:00:00.000' AS DateTime), CAST(N'2015-10-13T00:00:00.000' AS DateTime), NULL, NULL, 4, 100, N'CA', 0, 0, NULL, NULL, NULL, N'LU1249211803', NULL, N'51115', NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (8, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Income Opportunity I EUR', N'Efficiency Growth Fund - Income Opportunity I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1620753571', N'36692596', N'33646', NULL, N'A2DYLU', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (8, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds Income Opportunity I EUR', N'GFG Funds Income Opportunity I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1620753571', N'36692596', N'33646', NULL, N'A2DYLU', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (9, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Income Opportunity P EUR', N'Efficiency Growth Fund - Income Opportunity P EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1620753811', N'36695603', N'33646', NULL, N'A2DYLV', NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (9, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds Income Opportunity P EUR', N'GFG Funds Income Opportunity P EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1620753811', N'36695603', N'33646', NULL, N'A2DYLV', NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (10, CAST(N'2015-12-21T00:00:00.000' AS DateTime), NULL, N'Emerald Sicav Euro Investment Grade Bond I EUR', N'Emerald Sicav Euro Investment Grade Bond I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-12-21T00:00:00.000' AS DateTime), CAST(N'2015-12-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, N'EMEIGBI LX', NULL, N'LU1336188484', N'30734142', N'8062', NULL, N'A2AH7S', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (11, CAST(N'2016-09-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), N'Emerald Sicav Euro Investment Grade Bond II EUR', N'Emerald Sicav Euro Investment Grade Bond II EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-09-14T00:00:00.000' AS DateTime), CAST(N'2016-09-14T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, NULL, NULL, N'EMEIGII LX', NULL, N'LU1462003622', N'33337919', N'8062', NULL, N'A2DW3U', NULL, N'II', N'dormant', N'DORMANT')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (11, CAST(N'2020-03-16T00:00:00.000' AS DateTime), NULL, N'Emerald Sicav Euro Investment Grade Bond II EUR', N'Emerald Sicav Euro Investment Grade Bond II EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-09-14T00:00:00.000' AS DateTime), CAST(N'2016-09-14T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C4', 0, 0, NULL, N'EMEIGII LX', NULL, N'LU1462003622', N'33337919', N'8062', NULL, N'A2DW3U', NULL, N'II', N'dormant', N'DORMANT')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (12, CAST(N'2015-12-17T00:00:00.000' AS DateTime), NULL, N'Emerald Sicav Euro Investment Grade Bond R EUR', N'Emerald Sicav Euro Investment Grade Bond R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-12-17T00:00:00.000' AS DateTime), CAST(N'2015-12-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU1336188211', N'30733839', N'8062', NULL, N'A2DK8A', NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (13, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Emerald Sicav Euro Investment Grade Bond RR EUR', N'Emerald Sicav Euro Investment Grade Bond RR EUR', 1, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 1, 100, N'C3', 0, NULL, NULL, N'EMEIGRR LX', NULL, N'LU1462002228', N'33337912', N'8062', NULL, N'A2DGRM', NULL, N'RR', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (14, CAST(N'2017-12-19T00:00:00.000' AS DateTime), NULL, N'Emerald Sicav Euro Inflation-Linked Bond R EUR', N'Emerald Sicav Euro Inflation-Linked Bond R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-19T00:00:00.000' AS DateTime), CAST(N'2017-12-19T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU1737062783', N'39544945', N'88057', NULL, N'A2JE3C', NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (15, CAST(N'2017-12-29T00:00:00.000' AS DateTime), NULL, N'Emerald Sicav Euro Inflation-Linked Bond I EUR', N'Emerald Sicav Euro Inflation-Linked Bond I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-12-29T00:00:00.000' AS DateTime), CAST(N'2017-12-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, NULL, NULL, N'LU1737062866', N'39544947', N'88057', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (16, CAST(N'2017-02-06T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Active Income Fund I EUR', N'Timeo Neutral Sicav BZ Active Income Fund I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-02-06T00:00:00.000' AS DateTime), CAST(N'2017-02-06T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, NULL, NULL, NULL, NULL, N'LU0857402530', N'20005497', N'32679', N'32679', N'A2DX5E', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (17, CAST(N'2014-07-03T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Active Income Fund I USD', N'Timeo Neutral Sicav BZ Active Income Fund I USD', 4, 1, N'USD', NULL, NULL, CAST(N'2014-07-03T00:00:00.000' AS DateTime), CAST(N'2014-07-03T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C6', 1, NULL, NULL, N'NEUGAIU LX', NULL, N'LU1080257949', N'24698897', N'32681', N'32681', N'A2DX5D', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (18, CAST(N'2012-11-29T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Active Income Fund R EUR', N'Timeo Neutral Sicav BZ Active Income Fund R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-11-29T00:00:00.000' AS DateTime), CAST(N'2012-11-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, N'NEUGAAR LX', NULL, N'LU0857402373', N'20005494', N'32676', N'32676', N'A2DLHA', NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (19, CAST(N'2012-06-29T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Conservative Wolf Fund I EUR', N'Timeo Neutral Sicav BZ Conservative Wolf Fund I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2012-06-29T00:00:00.000' AS DateTime), CAST(N'2012-06-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, NULL, NULL, N'NWOLFIE LX', NULL, N'LU0792923541', N'18761192', N'32537', NULL, N'A2PBZ0', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (20, CAST(N'2013-01-31T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Conservative Wolf Fund I USD', N'Timeo Neutral Sicav BZ Conservative Wolf Fund I USD', 4, 1, N'USD', NULL, NULL, CAST(N'2013-01-31T00:00:00.000' AS DateTime), CAST(N'2013-01-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C6', 1, NULL, NULL, N'NWOLFIU LX', NULL, N'LU0875482522', N'20395756', N'32537', NULL, N'A2PBZ1', NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (21, CAST(N'2012-07-19T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Conservative Wolf Fund R CHF', N'Timeo Neutral Sicav BZ Conservative Wolf Fund R CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2012-07-19T00:00:00.000' AS DateTime), CAST(N'2012-07-19T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 1, NULL, NULL, N'NWOLFRC LX', NULL, N'LU0805149647', N'18986994', N'32537', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (22, CAST(N'2012-06-29T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Conservative Wolf Fund R EUR', N'Timeo Neutral Sicav BZ Conservative Wolf Fund R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-06-29T00:00:00.000' AS DateTime), CAST(N'2012-06-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, N'NWOLFRE LX', NULL, N'LU0792923384', N'18761188', N'32537', NULL, N'A1J720', NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (23, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Conservative Wolf Fund I CHF', N'Timeo Neutral Sicav BZ Conservative Wolf Fund I CHF', 1, 1, N'CHF', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, N'C3', 1, 0, NULL, NULL, NULL, N'LU0875428822', NULL, N'32537', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (24, CAST(N'2018-06-18T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Amares Strategy Fund - Balanced A', N'Multi Stars SICAV Amares Strategy Fund - Balanced A', 1, 1, N'EUR', NULL, NULL, CAST(N'2019-05-02T00:00:00.000' AS DateTime), CAST(N'2019-05-02T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1842715168', NULL, N'LU6714', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (25, CAST(N'2015-03-27T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Cefisa Relative Strength Global Asset Allocation B EUR', N'Multi Stars SICAV Cefisa Relative Strength Global Asset Allocation B EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU0950572841', NULL, N'LU6275', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (26, CAST(N'2018-06-04T00:00:00.000' AS DateTime), CAST(N'2019-12-13T00:00:00.000' AS DateTime), N'Multi Stars SICAV Hearth Ethical Fund F USD', N'Multi Stars SICAV Hearth Ethical Fund F USD', 4, 1, N'USD', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1936207015', NULL, N'LU6658', NULL, NULL, NULL, N'F', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (27, CAST(N'2019-05-28T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Hearth Ethical Fund A1 EUR', N'Multi Stars SICAV Hearth Ethical Fund A1 EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1936207106', NULL, N'LU6658', NULL, NULL, NULL, N'A1', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (28, CAST(N'2019-05-22T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Hearth Ethical Fund Z EUR', N'Multi Stars SICAV Hearth Ethical Fund Z EUR', 6, 1, N'EUR', NULL, NULL, CAST(N'2019-11-07T00:00:00.000' AS DateTime), CAST(N'2019-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU2028896897', NULL, N'LU6658', NULL, NULL, NULL, N'Z', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (29, CAST(N'2019-05-28T00:00:00.000' AS DateTime), NULL, N'Multi Stars Sicav - Hearth Ethical Fund D CHF', N'Multi Stars Sicav - Hearth Ethical Fund D CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2019-12-10T00:00:00.000' AS DateTime), CAST(N'2019-12-10T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1936204939', NULL, N'LU6658', NULL, NULL, NULL, N'D', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (30, CAST(N'2010-06-16T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd I EUR', N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2010-06-16T00:00:00.000' AS DateTime), CAST(N'2010-06-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, NULL, NULL, N'VEGNILI LX', NULL, N'LU0469024839', N'11528166', N'32536', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (31, CAST(N'2013-01-24T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd I USD', N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd I USD', 4, 1, N'USD', NULL, NULL, CAST(N'2013-01-24T00:00:00.000' AS DateTime), CAST(N'2013-01-24T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C6', 1, NULL, NULL, N'NEUILBI LX', NULL, N'LU0875487752', N'20428863', N'32536', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (32, CAST(N'2012-02-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd R CHF', N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd R CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2012-02-01T00:00:00.000' AS DateTime), CAST(N'2012-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 1, NULL, NULL, N'NEUILBR LX', NULL, N'LU0738461291', N'14822597', N'32536', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (33, CAST(N'2003-08-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd R EUR', N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2003-08-01T00:00:00.000' AS DateTime), CAST(N'2003-08-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, N'VEGNILB LX', NULL, N'LU0172366956', N'1637913', N'32536', NULL, N'A0Q0UT', NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (34, CAST(N'2013-01-24T00:00:00.000' AS DateTime), CAST(N'2018-11-19T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd R USD', N'Timeo Neutral Sicav BZ Inflation Linked Bds Fd R USD', 1, 1, N'USD', NULL, NULL, CAST(N'2013-01-24T00:00:00.000' AS DateTime), CAST(N'2013-01-24T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C3', 1, NULL, NULL, NULL, NULL, N'LU0875486515', NULL, N'32536', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (35, CAST(N'2020-01-02T00:00:00.000' AS DateTime), NULL, N'Ritom Sicav - RAIF Archimede A EUR', N'Ritom Sicav - RAIF Archimede A EUR', 5, NULL, N'EUR', NULL, NULL, CAST(N'2020-01-31T00:00:00.000' AS DateTime), CAST(N'2020-01-31T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU2098359594', NULL, N'23764', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (36, CAST(N'2020-01-02T00:00:00.000' AS DateTime), NULL, N'Ritom Sicav - RAIF Archimede B EUR', N'Ritom Sicav - RAIF Archimede B EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU2098359677', NULL, N'23764', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (37, CAST(N'2020-01-02T00:00:00.000' AS DateTime), NULL, N'Ritom Sicav - RAIF Astipalea A EUR', N'Ritom Sicav - RAIF Astipalea A EUR', 5, NULL, N'EUR', NULL, NULL, CAST(N'2020-01-20T00:00:00.000' AS DateTime), CAST(N'2020-01-20T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU2098359750', NULL, N'23765', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (38, CAST(N'2020-01-02T00:00:00.000' AS DateTime), NULL, N'Ritom Sicav - RAIF Astipalea B EUR', N'Ritom Sicav - RAIF Astipalea B EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU2098359834', NULL, N'23765', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (39, CAST(N'2019-04-17T00:00:00.000' AS DateTime), NULL, N'GFG Funds Global Enhanced Cash I EUR', N'GFG Funds Global Enhanced Cash I EUR', 4, NULL, N'EUR', NULL, NULL, CAST(N'2020-03-05T00:00:00.000' AS DateTime), CAST(N'2020-03-05T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, N'C1', 0, 0, NULL, NULL, NULL, N'LU1981743435', NULL, N'38110', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (40, CAST(N'2019-04-17T00:00:00.000' AS DateTime), NULL, N'GFG Funds Global Enhanced Cash P EUR', N'GFG Funds Global Enhanced Cash P EUR', 1, NULL, N'EUR', NULL, NULL, CAST(N'2020-03-16T00:00:00.000' AS DateTime), CAST(N'2020-03-16T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, N'C2', 0, 0, NULL, NULL, NULL, N'LU1981743518', NULL, N'38110', NULL, NULL, NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (41, CAST(N'2019-04-17T00:00:00.000' AS DateTime), NULL, N'GFG Funds Global Enhanced Cash PP EUR', N'GFG Funds Global Enhanced Cash PP EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1981743609', NULL, N'38110', NULL, NULL, NULL, N'PP', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (42, CAST(N'2015-07-03T00:00:00.000' AS DateTime), CAST(N'2020-09-14T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav CFO America 38 I EUR', N'Timeo Neutral Sicav CFO America 38 I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-07-07T00:00:00.000' AS DateTime), CAST(N'2015-07-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1244114911', NULL, N'32724', N'32724', NULL, NULL, N'I', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (42, CAST(N'2020-09-15T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav CFO America 38 I EUR', N'Timeo Neutral Sicav CFO America 38 I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-07-07T00:00:00.000' AS DateTime), CAST(N'2015-07-07T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU1244114911', NULL, N'32724', N'32724', NULL, NULL, N'I', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (43, CAST(N'2015-09-22T00:00:00.000' AS DateTime), CAST(N'2020-09-14T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav CFO America 38 R EUR', N'Timeo Neutral Sicav CFO America 38 R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-09-22T00:00:00.000' AS DateTime), CAST(N'2015-09-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1256231405', NULL, N'32723', N'32723', NULL, NULL, N'R', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (43, CAST(N'2020-09-15T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav CFO America 38 R EUR', N'Timeo Neutral Sicav CFO America 38 R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-09-22T00:00:00.000' AS DateTime), CAST(N'2015-09-22T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C1', 0, 0, NULL, NULL, NULL, N'LU1256231405', NULL, N'32723', N'32723', NULL, NULL, N'R', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (44, CAST(N'2015-07-03T00:00:00.000' AS DateTime), CAST(N'2020-09-14T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav CFO Europa 38 I EUR', N'Timeo Neutral Sicav CFO Europa 38 I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-09-21T00:00:00.000' AS DateTime), CAST(N'2015-09-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, NULL, NULL, N'LU1244114671', NULL, N'32722', N'32722', NULL, NULL, N'I', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (44, CAST(N'2020-09-15T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav CFO Europa 38 I EUR', N'Timeo Neutral Sicav CFO Europa 38 I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-09-21T00:00:00.000' AS DateTime), CAST(N'2015-09-21T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU1244114671', NULL, N'32722', N'32722', NULL, NULL, N'I', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (45, CAST(N'2015-09-22T00:00:00.000' AS DateTime), CAST(N'2020-09-14T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav CFO Europa 38 R EUR', N'Timeo Neutral Sicav CFO Europa 38 R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-09-21T00:00:00.000' AS DateTime), CAST(N'2015-09-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU1256231587', NULL, N'32699', N'32699', NULL, NULL, N'R', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (45, CAST(N'2020-09-15T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav CFO Europa 38 R EUR', N'Timeo Neutral Sicav CFO Europa 38 R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-09-21T00:00:00.000' AS DateTime), CAST(N'2015-09-21T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C1', 0, 0, NULL, NULL, NULL, N'LU1256231587', NULL, N'32699', N'32699', NULL, NULL, N'R', N'SUBFUND in liquidation - Share dormant', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (46, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2019-08-06T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav Europ Abs Ret Fd A Institutional EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Institutional EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1506684098', N'34252803', NULL, NULL, NULL, NULL, N'A', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (46, CAST(N'2019-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Europ Abs Ret Fd A Institutional EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Institutional EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 2, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU1506684098', N'34252803', N'16400A', NULL, NULL, NULL, N'A', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (47, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2019-08-06T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav Europ Abs Ret Fd A Listed EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Listed EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C5', 0, 0, NULL, NULL, NULL, N'LU1506684254', N'34252812', NULL, NULL, N'A2H5X4', NULL, N'A', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (47, CAST(N'2019-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Europ Abs Ret Fd A Listed EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Listed EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 2, 0, N'C5', 0, 0, NULL, NULL, NULL, N'LU1506684254', N'34252812', N'16400C5', NULL, N'A2H5X4', NULL, N'A', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (48, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2019-08-06T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav Europ Abs Ret Fd A No Load EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A No Load EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1506683959', N'34252802', NULL, NULL, N'A2JCUY', NULL, N'A', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (48, CAST(N'2019-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Europ Abs Ret Fd A No Load EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A No Load EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C4', 0, 0, NULL, NULL, NULL, N'LU1506683959', N'34252802', N'16400C', NULL, N'A2JCUY', NULL, N'A', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (49, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2019-08-06T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU1506683793', N'34252791', NULL, NULL, NULL, NULL, NULL, N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (49, CAST(N'2019-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 2, 0, N'C1', 0, 0, NULL, NULL, NULL, N'LU1506683793', N'34252791', N'16400C1', NULL, NULL, NULL, NULL, N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (50, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2019-08-06T00:00:00.000' AS DateTime), N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH S2 EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH S2 EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, NULL, NULL, NULL, NULL, N'LU1506683876', N'34252798', NULL, NULL, NULL, NULL, NULL, N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (50, CAST(N'2019-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH S2 EUR', N'Timeo Neutral Sicav Europ Abs Ret Fd A Retail UH S2 EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 3, 0, N'C3', 0, 0, NULL, NULL, NULL, N'LU1506683876', N'34252798', N'16400C3', NULL, NULL, NULL, N'UH', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (51, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Long Short Credit Fund A CHF', N'Swan SICAV SIF SWAN Long Short Credit Fund A CHF', 5, 1, N'CHF', NULL, NULL, CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2020-07-27T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1019167318', NULL, N'19878', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (52, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Long Short Credit Fund A USD', N'Swan SICAV SIF SWAN Long Short Credit Fund A USD', 5, 1, N'USD', NULL, NULL, CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1019167151', NULL, N'19878', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (53, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Long Short Credit Fund B CHF', N'Swan SICAV SIF SWAN Long Short Credit Fund B CHF', 6, 1, N'CHF', NULL, NULL, CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1019167581', NULL, N'19878', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (54, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Long Short Credit Fund B USD', N'Swan SICAV SIF SWAN Long Short Credit Fund B USD', NULL, 1, N'USD', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1019167409', NULL, N'19878', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (55, CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Syntagma Absolute Return I EUR', N'Timeo Neutral Sicav Syntagma Absolute Return I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2018-08-07T00:00:00.000' AS DateTime), CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU1847646525', N'793973', NULL, NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (56, CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Syntagma Absolute Return R PRIME USD', N'Timeo Neutral Sicav Syntagma Absolute Return R PRIME USD', 1, 1, N'USD', NULL, NULL, CAST(N'2018-08-07T00:00:00.000' AS DateTime), CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1847645980', N'793973', NULL, NULL, N'A2PBMW', NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (57, CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Syntagma Absolute Return R PRIME EUR HGD', N'Timeo Neutral Sicav Syntagma Absolute Return R PRIME EUR HGD', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-08-07T00:00:00.000' AS DateTime), CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU1847646798', N'793973', NULL, NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (58, CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav Syntagma Absolute Return I USD', N'Timeo Neutral Sicav Syntagma Absolute Return I USD', 4, 1, N'USD', NULL, NULL, CAST(N'2018-08-07T00:00:00.000' AS DateTime), CAST(N'2018-08-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1847646368', N'793973', NULL, NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (59, CAST(N'2018-06-13T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Best Global Managers Flexible Equity A EUR', N'Timeo Neutral Sicav BZ Best Global Managers Flexible Equity A EUR', 1, NULL, N'EUR', NULL, NULL, CAST(N'2019-07-31T00:00:00.000' AS DateTime), CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 1, NULL, NULL, NULL, N'LU1850436491', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (60, CAST(N'2018-06-13T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Best Global Managers Flexible Equity I EUR', N'Timeo Neutral Sicav BZ Best Global Managers Flexible Equity I EUR', 4, NULL, N'EUR', NULL, NULL, CAST(N'2019-07-31T00:00:00.000' AS DateTime), CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1850436228', NULL, NULL, NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (61, CAST(N'2018-06-13T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral Sicav BZ Best Global Managers Flexible Equity R EUR', N'Timeo Neutral Sicav BZ Best Global Managers Flexible Equity R EUR', 1, NULL, N'EUR', NULL, NULL, CAST(N'2019-07-31T00:00:00.000' AS DateTime), CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1850436145', NULL, NULL, NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (62, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Athena Balanced R', N'1st SICAV Athena Balanced R', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-06-29T00:00:00.000' AS DateTime), CAST(N'2017-06-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1435778300', NULL, N'30658', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (63, CAST(N'2017-05-10T00:00:00.000' AS DateTime), CAST(N'2019-04-15T00:00:00.000' AS DateTime), N'1st SICAV Europe Small I', N'1st SICAV Europe Small I', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-05-10T00:00:00.000' AS DateTime), CAST(N'2017-05-10T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1435777914', NULL, NULL, NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (64, CAST(N'2017-05-05T00:00:00.000' AS DateTime), CAST(N'2019-04-15T00:00:00.000' AS DateTime), N'1st SICAV Europe Small R', N'1st SICAV Europe Small R', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-05-05T00:00:00.000' AS DateTime), CAST(N'2017-05-05T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1435777831', NULL, NULL, NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (65, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Hestia Conservative R', N'1st SICAV Hestia Conservative R', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-06-29T00:00:00.000' AS DateTime), CAST(N'2017-06-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1435778565', NULL, N'30659', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (66, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Italy I', N'1st SICAV Italy I', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-05-10T00:00:00.000' AS DateTime), CAST(N'2017-05-10T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1435777674', NULL, N'30656', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (67, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Italy R', N'1st SICAV Italy R', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-05-05T00:00:00.000' AS DateTime), CAST(N'2017-05-05T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1435777591', NULL, N'30656', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (68, CAST(N'2017-03-23T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV FLexible Credit A EUR', N'Kite Fund SICAV FLexible Credit A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2017-04-11T00:00:00.000' AS DateTime), CAST(N'2017-04-11T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D1', 0, 0, NULL, NULL, NULL, N'LU1550130873', NULL, N'26886', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (69, CAST(N'2012-09-11T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV Total Return A EUR', N'Kite Fund SICAV Total Return A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-10-08T00:00:00.000' AS DateTime), CAST(N'2012-10-08T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0830807797', NULL, N'22132', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (70, CAST(N'2010-03-31T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Absolute Return B EUR', N'Pharus Sicav Absolute Return B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2010-03-31T00:00:00.000' AS DateTime), CAST(N'2010-03-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0515577780', NULL, NULL, NULL, NULL, NULL, N'B', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (70, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Conservative B EUR', N'Pharus Sicav Conservative B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2010-03-31T00:00:00.000' AS DateTime), CAST(N'2010-03-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0515577780', NULL, N'40495BEUR', NULL, NULL, NULL, N'B', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (71, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Absolute Return C USD', N'Pharus Sicav Absolute Return C USD', 4, 1, N'USD', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 1, 0, NULL, NULL, NULL, N'LU1136401624', NULL, NULL, NULL, NULL, NULL, N'C', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (71, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Conservative C USD', N'Pharus Sicav Conservative C USD', 4, 1, N'USD', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 1, 0, NULL, NULL, NULL, N'LU1136401624', NULL, N'40495CUSD', NULL, NULL, NULL, N'C', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (72, CAST(N'2007-04-15T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Absolute Return A EUR', N'Pharus Sicav Absolute Return A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2007-04-15T00:00:00.000' AS DateTime), CAST(N'2007-04-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0291569647', NULL, NULL, NULL, NULL, NULL, N'A', N'changed name', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (72, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Conservative A EUR', N'Pharus Sicav Conservative A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2007-04-15T00:00:00.000' AS DateTime), CAST(N'2007-04-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0291569647', NULL, N'40495AEUR', NULL, NULL, NULL, N'A', N'changed name', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (73, CAST(N'2017-03-27T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Absolute Return E CHF', N'Pharus Sicav Absolute Return E CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2017-03-27T00:00:00.000' AS DateTime), CAST(N'2017-03-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1582234149', NULL, NULL, NULL, NULL, NULL, N'E', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (73, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Conservative E CHF', N'Pharus Sicav Conservative E CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2017-03-27T00:00:00.000' AS DateTime), CAST(N'2017-03-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1582234149', NULL, N'40495ECHF', NULL, NULL, NULL, N'E', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (74, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Absolute Return F CHF', N'Pharus Sicav Absolute Return F CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C5', 1, 0, NULL, NULL, NULL, N'LU1136401541', NULL, NULL, NULL, NULL, NULL, N'F', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (74, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Conservative F CHF', N'Pharus Sicav Conservative F CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C5', 1, 0, NULL, NULL, NULL, N'LU1136401541', NULL, N'40495FCHF', NULL, NULL, NULL, N'F', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (75, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Absolute Return Q EUR', N'Pharus Sicav Absolute Return Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136401467', NULL, NULL, NULL, NULL, NULL, N'Q', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (75, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Conservative Q EUR', N'Pharus Sicav Conservative Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136401467', NULL, N'40495QEUR', NULL, NULL, NULL, N'Q', N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (76, CAST(N'2012-12-02T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Algo Flex A EUR', N'Pharus Sicav Algo Flex A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-12-02T00:00:00.000' AS DateTime), CAST(N'2012-12-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0833009060', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (77, CAST(N'2012-02-21T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Algo Flex B EUR', N'Pharus Sicav Algo Flex B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2012-02-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0746320174', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (78, CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Algo Flex Q EUR', N'Pharus Sicav Algo Flex Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136402788', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (79, CAST(N'2016-05-20T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Athesis Total Return A EUR', N'Pharus Sicav Athesis Total Return A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-05-20T00:00:00.000' AS DateTime), CAST(N'2016-05-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1410343914', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
GO
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (80, CAST(N'2016-05-20T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Athesis Total Return B EUR', N'Pharus Sicav Athesis Total Return B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-05-20T00:00:00.000' AS DateTime), CAST(N'2016-05-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1410345455', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (81, CAST(N'2018-05-04T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Avantgarde A EUR', N'Pharus Sicav Avantgarde A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-05-04T00:00:00.000' AS DateTime), CAST(N'2018-05-04T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D3', 0, 0, NULL, NULL, NULL, N'LU1620769494', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (82, CAST(N'2016-12-15T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Avantgarde B EUR', N'Pharus Sicav Avantgarde B EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-12-15T00:00:00.000' AS DateTime), CAST(N'2016-12-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1424613740', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (83, CAST(N'2016-12-15T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Avantgarde C EUR', N'Pharus Sicav Avantgarde C EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-12-15T00:00:00.000' AS DateTime), CAST(N'2016-12-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1424614391', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (84, CAST(N'2017-06-26T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Avantgarde I EUR', N'Pharus Sicav Avantgarde I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-06-26T00:00:00.000' AS DateTime), CAST(N'2017-06-26T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1620769817', NULL, NULL, NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (85, CAST(N'2015-02-20T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target G EUR', N'Pharus Sicav Target G EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1732804247', NULL, NULL, NULL, NULL, NULL, N'G', N'class G becomes class A', N'CLASS G BECOMES CLASS A')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (85, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target A EUR', N'Pharus Sicav Target A EUR', 1, 1, N'EUR', N'LU', NULL, NULL, NULL, NULL, NULL, 4, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1732804247', NULL, N'AEUR', NULL, NULL, NULL, N'A', N'class G becomes class A', N'CLASS G BECOMES CLASS A')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (86, CAST(N'2019-01-18T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Next Revolution I2 EUR', N'Pharus Sicav Next Revolution I2 EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1882538066', NULL, NULL, NULL, NULL, NULL, N'I2', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (87, CAST(N'2016-07-11T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Avantgarde F USD', N'Pharus Sicav Avantgarde F USD', 4, 1, N'USD', NULL, NULL, CAST(N'2019-03-08T00:00:00.000' AS DateTime), CAST(N'2019-03-08T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU1882537928', NULL, NULL, NULL, NULL, NULL, N'F', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (88, CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Global Managers Flexible Equity A EUR', N'Pharus Sicav Best Global Managers Flexible Equity A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2011-07-08T00:00:00.000' AS DateTime), CAST(N'2011-07-08T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0645706689', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (89, CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Global Managers Flexible Equity B EUR', N'Pharus Sicav Best Global Managers Flexible Equity B EUR', 4, NULL, NULL, NULL, NULL, CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1842648898', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (90, CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Global Managers Flexible Equity Q EUR', N'Pharus Sicav Best Global Managers Flexible Equity Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C7', 0, NULL, NULL, NULL, NULL, N'LU1136402358', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (91, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Biotech A EUR', N'Pharus Sicav Biotech A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1491986011', NULL, NULL, NULL, NULL, NULL, N'A', N'rename the sub-fund into Pharus SICAV – Medical Innovation', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL IN')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (91, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Medical Innovation A EUR', N'Pharus Sicav Medical Innovation A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1491986011', NULL, N'AEUR', NULL, NULL, NULL, N'A', N'rename the sub-fund into Pharus SICAV – Medical Innovation', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL IN')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (92, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Biotech E USD', N'Pharus Sicav Biotech E USD', 1, 1, N'USD', NULL, NULL, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C5', 1, 0, NULL, NULL, NULL, N'LU1491986441', NULL, NULL, NULL, NULL, NULL, N'E', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL INNOVATION AND E BECOMES AH', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL IN')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (92, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Medical Innovation AH USD', N'Pharus Sicav Medical Innovation AH USD', 1, 1, N'USD', N'LU', NULL, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 0, N'C5', 1, 0, NULL, NULL, NULL, N'LU1491986441', NULL, N'AHUSD', NULL, NULL, NULL, N'AHUSD', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL INNOVATION AND E BECOMES AH', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL IN')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (93, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Biotech I EUR', N'Pharus Sicav Biotech I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1491986102', NULL, NULL, NULL, NULL, NULL, N'I', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL INNOVATION AND CLASS I BECOMES B', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL IN')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (93, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Medical Innovation B EUR', N'Pharus Sicav Medical Innovation B EUR', 4, 1, N'EUR', N'LU', NULL, CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1491986102', NULL, N'BEUR', NULL, NULL, NULL, N'B', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL INNOVATION AND CLASS I BECOMES B', N'RENAME THE SUB-FUND INTO PHARUS SICAV – MEDICAL IN')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (94, CAST(N'2003-01-31T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Bond Opportunities A EUR', N'Pharus Sicav Bond Opportunities A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2003-01-31T00:00:00.000' AS DateTime), CAST(N'2003-01-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0159790970', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (95, CAST(N'2008-05-21T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Bond Opportunities B EUR', N'Pharus Sicav Bond Opportunities B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2008-05-21T00:00:00.000' AS DateTime), CAST(N'2008-05-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0365512168', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (96, CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Bond Opportunities C USD', N'Pharus Sicav Bond Opportunities C USD', 4, 2, N'USD', NULL, NULL, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'DD', 1, 0, NULL, NULL, NULL, N'LU0985039519', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (97, CAST(N'2018-07-23T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Bond Opportunities D EUR', N'Pharus Sicav Bond Opportunities D EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2018-07-23T00:00:00.000' AS DateTime), CAST(N'2018-07-23T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1834915123', NULL, NULL, NULL, NULL, NULL, N'D', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (98, CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Bond Opportunities Q EUR', N'Pharus Sicav Bond Opportunities Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 0, NULL, NULL, NULL, N'LU1136401111', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (99, CAST(N'2017-03-17T00:00:00.000' AS DateTime), CAST(N'2020-03-04T00:00:00.000' AS DateTime), N'Pharus Sicav Bond Value A EUR', N'Pharus Sicav Bond Value A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-03-17T00:00:00.000' AS DateTime), CAST(N'2017-03-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CA', 0, 0, NULL, NULL, NULL, N'LU1480634275', NULL, NULL, NULL, NULL, NULL, N'A', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (99, CAST(N'2020-03-05T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Bond Value A EUR', N'Pharus Sicav Bond Value A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-03-17T00:00:00.000' AS DateTime), CAST(N'2017-03-17T00:00:00.000' AS DateTime), CAST(N'2020-03-05T00:00:00.000' AS DateTime), NULL, 2, 100, N'CA', 0, 0, NULL, NULL, NULL, N'LU1480634275', NULL, N'17390A', NULL, NULL, NULL, N'A', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (100, CAST(N'2017-05-12T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Deepview Trading A EUR', N'Pharus Sicav Deepview Trading A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-05-12T00:00:00.000' AS DateTime), CAST(N'2017-05-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1502105775', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (101, CAST(N'2017-05-12T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Deepview Trading B EUR', N'Pharus Sicav Deepview Trading B EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-05-12T00:00:00.000' AS DateTime), CAST(N'2017-05-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1502105858', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (102, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Deepview Trading C EUR', N'Pharus Sicav Deepview Trading C EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1834915479', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (103, CAST(N'2011-07-25T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav EOS A1 EUR', N'Pharus Sicav EOS A1 EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2011-07-25T00:00:00.000' AS DateTime), CAST(N'2011-07-25T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0649901526', NULL, NULL, NULL, NULL, NULL, N'A1', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (104, CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return A EUR', N'Pharus Sicav Europe Total Return A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1437803098', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (105, CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return B CHF', N'Pharus Sicav Europe Total Return B CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 1, 0, NULL, NULL, NULL, N'LU1437803171', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (106, CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return C USD', N'Pharus Sicav Europe Total Return C USD', 1, 1, N'USD', NULL, NULL, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 1, 0, NULL, NULL, NULL, N'LU1437803254', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (107, CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return D EUR', N'Pharus Sicav Europe Total Return D EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C5', 0, 0, NULL, NULL, NULL, N'LU1437803411', NULL, NULL, NULL, NULL, NULL, N'D', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (108, CAST(N'2017-09-26T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return E CHF', N'Pharus Sicav Europe Total Return E CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2017-09-26T00:00:00.000' AS DateTime), CAST(N'2017-09-26T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C6', 1, 0, NULL, NULL, NULL, N'LU1437803502', NULL, NULL, NULL, NULL, NULL, N'E', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (109, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return F USD', N'Pharus Sicav Europe Total Return F USD', 1, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, N'C7', 0, 0, NULL, NULL, NULL, N'LU1437803684', NULL, NULL, NULL, NULL, NULL, N'F', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (110, CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return G EUR', N'Pharus Sicav Europe Total Return G EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1437803338', NULL, NULL, NULL, NULL, NULL, N'G', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (111, CAST(N'2018-05-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return H EUR', N'Pharus Sicav Europe Total Return H EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2018-05-22T00:00:00.000' AS DateTime), CAST(N'2018-05-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C9', 0, 0, NULL, NULL, NULL, N'LU1819985471', NULL, NULL, NULL, NULL, NULL, N'H', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (112, CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Europe Total Return Q EUR', N'Pharus Sicav Europe Total Return Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C8', 0, 1, NULL, NULL, NULL, N'LU1437803767', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (113, CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2020-05-25T00:00:00.000' AS DateTime), N'Pharus Sicav Global Dynamic Opportunities A EUR', N'Pharus Sicav Global Dynamic Opportunities A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2014-01-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0881534563', NULL, NULL, NULL, NULL, NULL, N'A', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (113, CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Dynamic Opportunities A EUR', N'Pharus Sicav Global Dynamic Opportunities A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, 2, 0, N'C1', 0, 0, NULL, NULL, NULL, N'LU0881534563', NULL, N'19684A', NULL, NULL, NULL, N'A', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (114, CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2020-05-25T00:00:00.000' AS DateTime), N'Pharus Sicav Global Dynamic Opportunities B EUR', N'Pharus Sicav Global Dynamic Opportunities B EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2014-01-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0881534720', NULL, NULL, NULL, NULL, NULL, N'B', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (114, CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Dynamic Opportunities B EUR', N'Pharus Sicav Global Dynamic Opportunities B EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2014-01-31T00:00:00.000' AS DateTime), CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, 2, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU0881534720', NULL, N'19684C2', NULL, NULL, NULL, N'B', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (115, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2020-05-25T00:00:00.000' AS DateTime), N'Pharus Sicav Global Dynamic Opportunities C EUR', N'Pharus Sicav Global Dynamic Opportunities C EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1198470442', NULL, NULL, NULL, NULL, NULL, N'C', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (115, CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Dynamic Opportunities C EUR', N'Pharus Sicav Global Dynamic Opportunities C EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, 2, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1198470442', NULL, N'19684C', NULL, NULL, NULL, N'C', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (116, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2020-03-11T00:00:00.000' AS DateTime), N'Pharus Sicav Global Dynamic Opportunities Q EUR', N'Pharus Sicav Global Dynamic Opportunities Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136402945', NULL, NULL, NULL, NULL, NULL, N'Q', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (116, CAST(N'2020-03-12T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Dynamic Opportunities Q EUR', N'Pharus Sicav Global Dynamic Opportunities Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2020-03-12T00:00:00.000' AS DateTime), NULL, 2, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136402945', NULL, N'19684Q', NULL, NULL, NULL, N'Q', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (117, CAST(N'2016-04-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity A EUR', N'Pharus Sicav Global Value Equity A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-04-01T00:00:00.000' AS DateTime), CAST(N'2016-04-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1371477776', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (118, CAST(N'2016-04-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity AH EUR', N'Pharus Sicav Global Value Equity AH EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-04-01T00:00:00.000' AS DateTime), CAST(N'2016-04-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CA', 0, 0, NULL, NULL, NULL, N'LU1371477859', NULL, NULL, NULL, NULL, NULL, N'AH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (119, CAST(N'2016-02-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity C EUR', N'Pharus Sicav Global Value Equity C EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2016-02-29T00:00:00.000' AS DateTime), CAST(N'2016-02-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D3', 0, 0, NULL, NULL, NULL, N'LU1371478154', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (120, CAST(N'2016-02-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity D EUR', N'Pharus Sicav Global Value Equity D EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-02-29T00:00:00.000' AS DateTime), CAST(N'2016-02-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1371478238', NULL, NULL, NULL, NULL, NULL, N'D', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (121, CAST(N'2016-06-17T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity I EUR', N'Pharus Sicav Global Value Equity I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-06-17T00:00:00.000' AS DateTime), CAST(N'2016-06-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C8', 0, 0, NULL, NULL, NULL, N'LU1427873770', NULL, NULL, NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (122, CAST(N'2016-06-17T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity IH EUR', N'Pharus Sicav Global Value Equity IH EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-06-17T00:00:00.000' AS DateTime), CAST(N'2016-06-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C9', 0, 0, NULL, NULL, NULL, N'LU1427874158', NULL, NULL, NULL, NULL, NULL, N'IH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (123, CAST(N'2016-05-27T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity Q EUR', N'Pharus Sicav Global Value Equity Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-05-27T00:00:00.000' AS DateTime), CAST(N'2016-05-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1371515534', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (124, CAST(N'2016-05-27T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity QH EUR', N'Pharus Sicav Global Value Equity QH EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-05-27T00:00:00.000' AS DateTime), CAST(N'2016-05-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CI', 0, 1, NULL, NULL, NULL, N'LU1371515880', NULL, NULL, NULL, NULL, NULL, N'QH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (125, CAST(N'2017-06-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Value Equity QHD EUR', N'Pharus Sicav Global Value Equity QHD EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2017-06-01T00:00:00.000' AS DateTime), CAST(N'2017-06-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D5', 0, 1, NULL, NULL, NULL, N'LU1574104151', NULL, NULL, NULL, NULL, NULL, N'QHD', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (126, CAST(N'2016-05-20T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav I-Bond Plus Solution A USD', N'Pharus Sicav I-Bond Plus Solution A USD', 1, 2, N'USD', NULL, NULL, CAST(N'2016-05-20T00:00:00.000' AS DateTime), CAST(N'2016-05-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CA', 0, 0, NULL, NULL, NULL, N'LU1410342601', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (127, CAST(N'2017-09-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav I-Bond Plus Solution G USD', N'Pharus Sicav I-Bond Plus Solution G USD', 1, 1, N'USD', NULL, NULL, CAST(N'2017-09-01T00:00:00.000' AS DateTime), CAST(N'2017-09-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1662734398', NULL, NULL, NULL, NULL, NULL, N'G', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (128, CAST(N'2010-01-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav International Eq Quant A EUR', N'Pharus Sicav International Eq Quant A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2010-01-29T00:00:00.000' AS DateTime), CAST(N'2010-01-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0471904796', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (129, CAST(N'2010-01-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav International Eq Quant B EUR', N'Pharus Sicav International Eq Quant B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2010-01-29T00:00:00.000' AS DateTime), CAST(N'2010-01-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0471904879', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (130, CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav International Equity Quant Q EUR', N'Pharus Sicav International Equity Quant Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136402192', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (131, CAST(N'2002-12-20T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Liquidity A EUR', N'Pharus Sicav Liquidity A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2002-12-20T00:00:00.000' AS DateTime), CAST(N'2002-12-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0159791275', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (132, CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Liquidity B USD', N'Pharus Sicav Liquidity B USD', 4, 1, N'USD', NULL, NULL, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 1, 0, NULL, NULL, NULL, N'LU0985039436', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (133, CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Liquidity E CHF', N'Pharus Sicav Liquidity E CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1136401202', NULL, NULL, NULL, NULL, NULL, N'E', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (134, CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Liquidity Q EUR', N'Pharus Sicav Liquidity Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136401384', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (135, CAST(N'2016-04-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Marzotto Active Bond A EUR', N'Pharus Sicav Marzotto Active Bond A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-04-22T00:00:00.000' AS DateTime), CAST(N'2016-04-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1371477263', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (136, CAST(N'2016-04-15T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Marzotto Active Bond B EUR', N'Pharus Sicav Marzotto Active Bond B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-04-15T00:00:00.000' AS DateTime), CAST(N'2016-04-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1371477347', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (137, CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2020-04-13T00:00:00.000' AS DateTime), N'Pharus Sicav Marzotto Active Bond Q EUR', N'Pharus Sicav Marzotto Active Bond Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2016-06-13T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1371515021', NULL, NULL, NULL, NULL, NULL, N'Q', N'Closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (137, CAST(N'2020-04-14T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Marzotto Active Bond Q EUR', N'Pharus Sicav Marzotto Active Bond Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 0, N'C7', 0, 1, NULL, NULL, NULL, N'LU1371515021', NULL, N'9887A', NULL, NULL, NULL, N'Q', N'Closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (138, CAST(N'2016-04-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Marzotto Active Diversified A EUR', N'Pharus Sicav Marzotto Active Diversified A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-04-22T00:00:00.000' AS DateTime), CAST(N'2016-04-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1371477420', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (139, CAST(N'2016-04-15T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Marzotto Active Diversified B EUR', N'Pharus Sicav Marzotto Active Diversified B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-04-15T00:00:00.000' AS DateTime), CAST(N'2016-04-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1371477693', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (140, CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'Pharus Sicav Marzotto Active Diversified Q EUR', N'Pharus Sicav Marzotto Active Diversified Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2016-06-13T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1371515294', NULL, NULL, NULL, NULL, NULL, N'Q', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (140, CAST(N'2020-02-14T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Marzotto Active Diversified Q EUR', N'Pharus Sicav Marzotto Active Diversified Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2016-06-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 0, N'C7', 0, 1, NULL, NULL, NULL, N'LU1371515294', NULL, N'9887Q', NULL, NULL, NULL, N'Q', N'closed', N'CLOSED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (141, CAST(N'2012-02-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Dynamic Allocation MV7 B EUR', N'Pharus Sicav Dynamic Allocation MV7 B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2012-02-29T00:00:00.000' AS DateTime), CAST(N'2012-02-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU0746320331', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (142, CAST(N'2012-02-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Dynamic Allocation MV7 A EUR', N'Pharus Sicav Dynamic Allocation MV7 A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-02-29T00:00:00.000' AS DateTime), CAST(N'2012-02-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0746320257', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (143, CAST(N'2015-12-09T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Southern Europe A EUR', N'Pharus Sicav Southern Europe A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-12-22T00:00:00.000' AS DateTime), CAST(N'2015-12-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1278160939', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (144, CAST(N'2015-12-09T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Southern Europe B EUR', N'Pharus Sicav Southern Europe B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-12-09T00:00:00.000' AS DateTime), CAST(N'2015-12-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1278161150', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (145, CAST(N'2018-01-31T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Southern Europe C EUR', N'Pharus Sicav Southern Europe C EUR', 1, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 3, 100, N'C3', 0, NULL, NULL, NULL, NULL, N'LU1330685899', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (146, CAST(N'2018-06-28T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Southern Europe Q EUR', N'Pharus Sicav Southern Europe Q EUR', 1, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 3, 100, N'C7', 0, NULL, NULL, NULL, NULL, N'LU1578646025', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (147, CAST(N'2019-03-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Swan Dynamic A EUR', N'Pharus Sicav Swan Dynamic A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-10-12T00:00:00.000' AS DateTime), CAST(N'2015-10-12T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1253867417', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (148, CAST(N'2019-03-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Swan Dynamic B EUR', N'Pharus Sicav Swan Dynamic B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-04-01T00:00:00.000' AS DateTime), CAST(N'2016-04-01T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1384920283', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (149, CAST(N'2019-03-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Swan Dynamic C EUR', N'Pharus Sicav Swan Dynamic C EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2018-07-30T00:00:00.000' AS DateTime), CAST(N'2018-07-30T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1834915396', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (150, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target A EUR', N'Pharus Sicav Target A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2012-02-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D1', 0, 0, NULL, NULL, NULL, N'LU0746320414', NULL, NULL, NULL, NULL, NULL, N'A', N'class A becomes class AD', N'CLASS A BECOMES CLASS AD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (150, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target AD EUR', N'Pharus Sicav Target AD EUR', 1, 2, N'EUR', N'LU', NULL, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2012-02-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D1', 0, 0, NULL, NULL, NULL, N'LU0746320414', NULL, N'ADEUR', NULL, NULL, NULL, N'AD', N'class A becomes class AD', N'CLASS A BECOMES CLASS AD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (151, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target B EUR', N'Pharus Sicav Target B EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2012-02-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D2', 0, 0, NULL, NULL, NULL, N'LU0746320505', NULL, NULL, NULL, NULL, NULL, N'B', N'class B becomes class BD', N'CLASS B BECOMES CLASS BD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (151, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target BD EUR', N'Pharus Sicav Target BD EUR', 4, 2, N'EUR', N'LU', NULL, CAST(N'2012-02-21T00:00:00.000' AS DateTime), CAST(N'2012-02-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D2', 0, 0, NULL, NULL, NULL, N'LU0746320505', NULL, N'BDEUR', NULL, NULL, NULL, N'BD', N'class B becomes class BD', N'CLASS B BECOMES CLASS BD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (152, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target C USD', N'Pharus Sicav Target C USD', 4, 2, N'USD', NULL, NULL, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'DD', 1, 0, NULL, NULL, NULL, N'LU0985039352', NULL, NULL, NULL, NULL, NULL, N'C', N'class C becomes class BH - USD', N'CLASS C BECOMES CLASS BH - USD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (152, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target BH USD', N'Pharus Sicav Target BH USD', 4, 2, N'USD', NULL, NULL, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'BHUSD', 1, 0, NULL, NULL, NULL, N'LU0985039352', NULL, N'BHUSD', NULL, NULL, NULL, N'BH', N'class C becomes class BH - USD', N'CLASS C BECOMES CLASS BH - USD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (153, CAST(N'2017-03-27T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target E CHF', N'Pharus Sicav Target E CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2017-03-27T00:00:00.000' AS DateTime), CAST(N'2017-03-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1582233844', NULL, NULL, NULL, NULL, NULL, N'E', N'class E becomes class AH - CHF', N'CLASS E BECOMES CLASS AH - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (153, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target AH CHF', N'Pharus Sicav Target AH CHF', 1, 1, N'CHF', N'LU', NULL, CAST(N'2017-03-27T00:00:00.000' AS DateTime), CAST(N'2017-03-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1582233844', NULL, N'AHCHF', NULL, NULL, NULL, N'AH', N'class E becomes class AH - CHF', N'CLASS E BECOMES CLASS AH - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (154, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target F CHF', N'Pharus Sicav Target F CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D5', 1, 0, NULL, NULL, NULL, N'LU1136402606', NULL, NULL, NULL, NULL, NULL, N'F', N'class F becomes class BH - CHF', N'CLASS F BECOMES CLASS BH - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (154, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target BH CHF', N'Pharus Sicav Target BH CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D5', 1, 0, NULL, NULL, NULL, N'LU1136402606', NULL, N'BHCHF', NULL, NULL, NULL, N'BH CHF', N'class F becomes class BH - CHF', N'CLASS F BECOMES CLASS BH - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (155, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Pharus Sicav Target H EUR', N'Pharus Sicav Target H EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C6', 0, 0, NULL, NULL, NULL, N'LU1136402515', NULL, NULL, NULL, NULL, NULL, N'H', N'class H becomes class B', N'CLASS H BECOMES CLASS B')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (155, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target B EUR', N'Pharus Sicav Target B EUR', 4, 1, N'EUR', N'LU', NULL, CAST(N'2015-03-09T00:00:00.000' AS DateTime), CAST(N'2015-03-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C6', 0, 0, NULL, NULL, NULL, N'LU1136402515', NULL, N'BEUR', NULL, NULL, NULL, N'B', N'class H becomes class B', N'CLASS H BECOMES CLASS B')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (156, CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target Q EUR', N'Pharus Sicav Target Q EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2015-05-29T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D7', 0, 1, NULL, NULL, NULL, N'LU1136402432', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (157, CAST(N'2015-10-12T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Tikehon Global Growth & Income Fund A EUR', N'Pharus Sicav Tikehon Global Growth & Income Fund A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2015-10-12T00:00:00.000' AS DateTime), CAST(N'2015-10-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1253867250', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (158, CAST(N'2015-10-12T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Tikehon Global Growth & Income Fund B EUR', N'Pharus Sicav Tikehon Global Growth & Income Fund B EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2015-10-12T00:00:00.000' AS DateTime), CAST(N'2015-10-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1253867334', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (159, CAST(N'2017-11-03T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Tikehon Global Growth & Income Fund C EUR', N'Pharus Sicav Tikehon Global Growth & Income Fund C EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-11-03T00:00:00.000' AS DateTime), CAST(N'2017-11-03T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1310644387', NULL, NULL, NULL, NULL, NULL, N'C', N'change of name of Share Class C into Share Class S', N'CHANGE OF NAME OF SHARE CLASS C INTO SHARE CLASS S')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (159, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Tikehon Global Growth & Income Fund S EUR', N'Pharus Sicav Tikehon Global Growth & Income Fund S EUR', 1, 1, N'EUR', N'LU', NULL, CAST(N'2017-11-03T00:00:00.000' AS DateTime), CAST(N'2017-11-03T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1310644387', NULL, N'SEUR', NULL, NULL, NULL, N'S', N'change of name of Share Class C into Share Class S', N'CHANGE OF NAME OF SHARE CLASS C INTO SHARE CLASS S')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (160, CAST(N'2009-12-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Titan Aggressive A EUR', N'Pharus Sicav Titan Aggressive A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2009-12-22T00:00:00.000' AS DateTime), CAST(N'2009-12-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0471904440', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (161, CAST(N'2016-07-15T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Trend Player A EUR', N'Pharus Sicav Trend Player A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-07-15T00:00:00.000' AS DateTime), CAST(N'2016-07-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1253867508', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
GO
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (162, CAST(N'2015-11-16T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Trend Player B EUR', N'Pharus Sicav Trend Player B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-11-16T00:00:00.000' AS DateTime), CAST(N'2015-11-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1253867763', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (163, CAST(N'2016-01-08T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Trend Player Q EUR', N'Pharus Sicav Trend Player Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-01-08T00:00:00.000' AS DateTime), CAST(N'2016-01-08T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1253867847', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (164, CAST(N'2009-11-30T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Flexible Bond A EUR', N'Pharus Sicav Global Flexible Bond A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2009-11-30T00:00:00.000' AS DateTime), CAST(N'2009-11-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0460960882', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (165, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-03-06T00:00:00.000' AS DateTime), N'Pharus Sicav Value A EUR', N'Pharus Sicav Value A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2008-06-10T00:00:00.000' AS DateTime), CAST(N'2008-06-10T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0368595129', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (165, CAST(N'2019-03-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Next Revolution A EUR', N'Pharus Sicav Next Revolution A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2008-06-10T00:00:00.000' AS DateTime), CAST(N'2008-06-10T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0368595129', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (166, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-03-06T00:00:00.000' AS DateTime), N'Pharus Sicav Value B EUR', N'Pharus Sicav Value B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2010-03-31T00:00:00.000' AS DateTime), CAST(N'2010-03-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0515578911', NULL, NULL, NULL, NULL, NULL, N'B', N'Changed name', N'Changed Name')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (166, CAST(N'2019-03-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Next Revolution B EUR', N'Pharus Sicav Next Revolution B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2010-03-31T00:00:00.000' AS DateTime), CAST(N'2010-03-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0515578911', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (167, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-03-06T00:00:00.000' AS DateTime), N'Pharus Sicav Value C USD', N'Pharus Sicav Value C USD', 4, 1, N'USD', NULL, NULL, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CD', 1, 0, NULL, NULL, NULL, N'LU0985039600', NULL, NULL, NULL, NULL, NULL, N'C', N'Changed name', N'Changed Name')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (167, CAST(N'2019-03-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Next Revolution C USD', N'Pharus Sicav Next Revolution C USD', 4, 1, N'USD', NULL, NULL, CAST(N'2013-10-17T00:00:00.000' AS DateTime), CAST(N'2013-10-17T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CD', 1, 0, NULL, NULL, NULL, N'LU0985039600', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (168, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-03-06T00:00:00.000' AS DateTime), N'Pharus Sicav Value Q EUR', N'Pharus Sicav Value Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-25T00:00:00.000' AS DateTime), CAST(N'2015-05-25T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136401970', NULL, NULL, NULL, NULL, NULL, N'Q', N'Changed name', N'Changed Name')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (168, CAST(N'2019-03-07T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Next Revolution Q EUR', N'Pharus Sicav Next Revolution Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2015-05-25T00:00:00.000' AS DateTime), CAST(N'2015-05-25T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C7', 0, 1, NULL, NULL, NULL, N'LU1136401970', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (169, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Bond Enhanced Fund A CHF', N'Swan SICAV SIF SWAN Bond Enhanced Fund A CHF', 5, 1, N'CHF', NULL, NULL, CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CV', 1, NULL, NULL, NULL, NULL, N'LU1019165965', NULL, N'19876', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (170, CAST(N'2013-06-24T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Bond Enhanced Fund A EUR', N'Swan SICAV SIF SWAN Bond Enhanced Fund A EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-06-24T00:00:00.000' AS DateTime), CAST(N'2013-06-24T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0849750368', NULL, N'19876', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (171, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Bond Enhanced Fund A USD', N'Swan SICAV SIF SWAN Bond Enhanced Fund A USD', 5, 1, N'USD', NULL, NULL, CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CB', 1, NULL, NULL, NULL, NULL, N'LU1019165882', NULL, N'19876', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (172, CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Bond Enhanced Fund B CHF', N'Swan SICAV SIF SWAN Bond Enhanced Fund B CHF', 5, 1, N'CHF', NULL, NULL, CAST(N'2014-01-15T00:00:00.000' AS DateTime), CAST(N'2014-01-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CW', 1, NULL, NULL, NULL, NULL, N'LU1019166187', NULL, N'19876', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (173, CAST(N'2013-06-24T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Bond Enhanced Fund B EUR', N'Swan SICAV SIF SWAN Bond Enhanced Fund B EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-06-24T00:00:00.000' AS DateTime), CAST(N'2013-06-24T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, NULL, NULL, N'LU0849750525', NULL, N'19876', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (174, CAST(N'2014-04-30T00:00:00.000' AS DateTime), CAST(N'2018-07-12T00:00:00.000' AS DateTime), N'Swan SICAV SIF SWAN Dynamic Fund A EUR', N'Swan SICAV SIF SWAN Dynamic Fund A EUR', 5, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU1064663518', NULL, NULL, NULL, NULL, NULL, N'A', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (174, CAST(N'2018-07-13T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund A EUR', N'Swan SICAV SIF SWAN Dynamic Fund A EUR', 5, 1, N'EUR', NULL, NULL, NULL, NULL, CAST(N'2018-07-13T00:00:00.000' AS DateTime), NULL, 2, 0, N'C1', 0, 0, NULL, NULL, NULL, N'LU1064663518', NULL, N'22187A', NULL, NULL, NULL, N'A', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (175, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund A1 EUR', N'Swan SICAV SIF SWAN Dynamic Fund A1 EUR', 5, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, N'C5', 0, NULL, NULL, NULL, NULL, N'LU1405993525', NULL, NULL, NULL, NULL, NULL, N'A1', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (176, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund A2 EUR', N'Swan SICAV SIF SWAN Dynamic Fund A2 EUR', 5, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, N'C6', 0, NULL, NULL, NULL, NULL, N'LU1405993798', NULL, NULL, NULL, NULL, NULL, N'A2', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (177, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund A3 EUR', N'Swan SICAV SIF SWAN Dynamic Fund A3 EUR', 5, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, N'C7', 0, NULL, NULL, NULL, NULL, N'LU1405993871', NULL, NULL, NULL, NULL, NULL, N'A3', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (178, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund A4 EUR', N'Swan SICAV SIF SWAN Dynamic Fund A4 EUR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1405993954', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (179, CAST(N'2015-10-16T00:00:00.000' AS DateTime), CAST(N'2018-10-11T00:00:00.000' AS DateTime), N'Swan SICAV SIF SWAN Dynamic Fund B CHF', N'Swan SICAV SIF SWAN Dynamic Fund B CHF', 5, 1, N'CHF', NULL, NULL, CAST(N'2015-10-16T00:00:00.000' AS DateTime), CAST(N'2015-10-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'CW', 1, NULL, NULL, NULL, NULL, N'LU1084810560', NULL, NULL, NULL, NULL, NULL, N'B', N'Liquidated', N'LUQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (179, CAST(N'2018-10-12T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund B CHF', N'Swan SICAV SIF SWAN Dynamic Fund B CHF', 5, 1, N'CHF', NULL, NULL, CAST(N'2015-10-16T00:00:00.000' AS DateTime), CAST(N'2015-10-16T00:00:00.000' AS DateTime), CAST(N'2018-10-12T00:00:00.000' AS DateTime), NULL, 2, 0, N'CW', 1, 0, NULL, NULL, NULL, N'LU1084810560', NULL, N'22187B', NULL, NULL, NULL, N'B', N'Liquidated', N'LUQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (180, CAST(N'2014-04-30T00:00:00.000' AS DateTime), CAST(N'2018-10-11T00:00:00.000' AS DateTime), N'Swan SICAV SIF SWAN Dynamic Fund B EUR', N'Swan SICAV SIF SWAN Dynamic Fund B EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2014-04-30T00:00:00.000' AS DateTime), CAST(N'2014-04-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, NULL, NULL, N'LU1064663609', NULL, NULL, NULL, NULL, NULL, N'B', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (180, CAST(N'2018-10-12T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund B EUR', N'Swan SICAV SIF SWAN Dynamic Fund B EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2014-04-30T00:00:00.000' AS DateTime), CAST(N'2014-04-30T00:00:00.000' AS DateTime), CAST(N'2018-10-12T00:00:00.000' AS DateTime), NULL, 2, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU1064663609', NULL, N'22187BEUR', NULL, NULL, NULL, N'B', N'LIQUIDATED', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (181, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund C EUR', N'Swan SICAV SIF SWAN Dynamic Fund C EUR', 5, 1, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, N'C3', 0, NULL, NULL, NULL, NULL, N'LU1064663781', NULL, NULL, NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (182, CAST(N'2015-04-07T00:00:00.000' AS DateTime), CAST(N'2019-12-12T00:00:00.000' AS DateTime), N'Swan SICAV SIF SWAN Dynamic Fund D EUR', N'Swan SICAV SIF SWAN Dynamic Fund D EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2015-04-07T00:00:00.000' AS DateTime), CAST(N'2015-04-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, NULL, NULL, NULL, NULL, N'LU1209099164', NULL, NULL, NULL, NULL, NULL, N'D', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (182, CAST(N'2019-12-13T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund D EUR', N'Swan SICAV SIF SWAN Dynamic Fund D EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2015-04-07T00:00:00.000' AS DateTime), CAST(N'2015-04-07T00:00:00.000' AS DateTime), CAST(N'2019-12-13T00:00:00.000' AS DateTime), NULL, 2, 0, N'C4', 0, 0, NULL, NULL, NULL, N'LU1209099164', NULL, N'22187BEUR', NULL, NULL, NULL, N'D', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (183, CAST(N'2018-01-26T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Dynamic Fund D CHF', N'Swan SICAV SIF SWAN Dynamic Fund D CHF', NULL, NULL, N'CHF', NULL, NULL, NULL, NULL, CAST(N'2018-01-26T00:00:00.000' AS DateTime), NULL, 2, 0, NULL, 0, 0, NULL, NULL, NULL, N'LU1209099321', NULL, N'LU1209099321', NULL, NULL, NULL, N'D', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (183, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2018-01-25T00:00:00.000' AS DateTime), N'Swan SICAV SIF SWAN Dynamic Fund D CHF', N'Swan SICAV SIF SWAN Dynamic Fund D CHF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1209099321', NULL, NULL, NULL, NULL, NULL, N'D', N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (184, CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Long Short Credit Fund A EUR', N'Swan SICAV SIF SWAN Long Short Credit Fund A EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0849750954', NULL, N'19878', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (185, CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Long Short Credit Fund B EUR', N'Swan SICAV SIF SWAN Long Short Credit Fund B EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, NULL, NULL, N'LU0849751093', NULL, N'19878', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (186, CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Multistrategy Fund A EUR', N'Swan SICAV SIF SWAN Multistrategy Fund A EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0849751176', NULL, N'19879', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (187, CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2020-11-26T00:00:00.000' AS DateTime), N'Swan SICAV SIF SWAN Multistrategy Fund B EUR', N'Swan SICAV SIF SWAN Multistrategy Fund B EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2013-02-04T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, NULL, NULL, NULL, NULL, N'LU0849751259', NULL, N'19879', NULL, NULL, NULL, N'B', N'Dormant - total redemption', N'DORMANT')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (187, CAST(N'2020-11-27T00:00:00.000' AS DateTime), NULL, N'Swan SICAV SIF SWAN Multistrategy Fund B EUR', N'Swan SICAV SIF SWAN Multistrategy Fund B EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2013-02-04T00:00:00.000' AS DateTime), CAST(N'2020-11-26T00:00:00.000' AS DateTime), NULL, 2, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU0849751259', NULL, N'19879', NULL, NULL, NULL, N'B', N'Dormant - total redemption', N'DORMANT')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (188, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2019-08-30T00:00:00.000' AS DateTime), N'Sifter Fund Global I EUR', N'Sifter Fund Global I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2003-06-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU0168577939', NULL, NULL, NULL, NULL, NULL, N'I', N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (188, CAST(N'2019-08-31T00:00:00.000' AS DateTime), NULL, N'Sifter Fund Global I EUR', N'Sifter Fund Global I EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2003-06-20T00:00:00.000' AS DateTime), NULL, NULL, 2, 0, N'C2', 0, 0, NULL, NULL, NULL, N'LU0168577939', NULL, N'38001I', NULL, NULL, NULL, N'I', N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (189, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2019-08-30T00:00:00.000' AS DateTime), N'Sifter Fund Global R EUR', N'Sifter Fund Global R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2003-06-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0168736675', NULL, NULL, NULL, NULL, NULL, N'R', N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (189, CAST(N'2019-08-31T00:00:00.000' AS DateTime), NULL, N'Sifter Fund Global R EUR', N'Sifter Fund Global R EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2003-06-20T00:00:00.000' AS DateTime), CAST(N'2003-06-20T00:00:00.000' AS DateTime), NULL, NULL, 2, 0, N'C1', 0, 0, NULL, NULL, NULL, N'LU0168736675', NULL, N'38001R', NULL, NULL, NULL, N'R', N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (190, CAST(N'2015-03-27T00:00:00.000' AS DateTime), CAST(N'2019-08-30T00:00:00.000' AS DateTime), N'Sifter Fund Global PI EUR', N'Sifter Fund Global PI EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-03-31T00:00:00.000' AS DateTime), CAST(N'2015-03-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 0, 0, NULL, NULL, NULL, N'LU1194076995', NULL, NULL, NULL, NULL, NULL, N'PI', N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (190, CAST(N'2019-08-31T00:00:00.000' AS DateTime), NULL, N'Sifter Fund Global PI EUR', N'Sifter Fund Global PI EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2015-03-31T00:00:00.000' AS DateTime), CAST(N'2015-03-31T00:00:00.000' AS DateTime), NULL, NULL, 2, 0, N'C4', 0, 0, NULL, NULL, NULL, N'LU1194076995', NULL, N'38001PI', NULL, NULL, NULL, N'PI', N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (191, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-12-13T00:00:00.000' AS DateTime), N'Multi Stars SICAV Hearth Ethical Fund AD EUR', N'Multi Stars SICAV Hearth Ethical Fund AD EUR', 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1720014320', NULL, N'LU6658', NULL, NULL, NULL, N'AD', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (192, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-11-14T00:00:00.000' AS DateTime), N'Multi Stars SICAV - AL-FA Dynamic Q EUR', N'Multi Stars SICAV - AL-FA Dynamic Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-10-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 1, NULL, NULL, NULL, N'LU1838949516', NULL, N'LU6266', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (192, CAST(N'2019-11-15T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV AL-FA Sustainable Megatrends Q EUR', N'Multi Stars SICAV AL-FA Sustainable Megatrends Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-10-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 1, NULL, NULL, NULL, N'LU1838949516', NULL, N'LU6266', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (193, CAST(N'2018-06-04T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Hearth Ethical Fund Q EUR', N'Multi Stars SICAV Hearth Ethical Fund Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-10-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 1, NULL, NULL, NULL, N'LU1838949607', NULL, N'LU6658', NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (194, CAST(N'2018-07-31T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Sureco US Core Equity CH CHF', N'Multi Stars SICAV Sureco US Core Equity CH CHF', 1, 1, N'CHF', NULL, NULL, CAST(N'2018-08-20T00:00:00.000' AS DateTime), CAST(N'2018-08-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1854151476', NULL, N'LU6304', NULL, NULL, NULL, N'CH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (195, CAST(N'2018-06-04T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Sureco US Core Equity C EUR', N'Multi Stars SICAV Sureco US Core Equity C EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-07-16T00:00:00.000' AS DateTime), CAST(N'2018-07-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1838949433', NULL, N'LU6304', NULL, NULL, NULL, N'C', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (196, CAST(N'2015-01-30T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Regent Serenity Fund B1 GBP', N'Multi Stars SICAV Regent Serenity Fund B1 GBP', 1, 1, N'GBP', NULL, NULL, CAST(N'2018-03-15T00:00:00.000' AS DateTime), CAST(N'2018-03-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C5', 0, 0, NULL, NULL, NULL, N'LU1760804770', NULL, N'LU6406', NULL, NULL, NULL, N'B1', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (197, CAST(N'2018-03-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Hearth Ethical Fund A EUR', N'Multi Stars SICAV Hearth Ethical Fund A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2018-03-02T00:00:00.000' AS DateTime), CAST(N'2018-03-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1720014247', NULL, N'LU6658', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (198, CAST(N'2017-09-29T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Cube A EUR', N'Multi Stars SICAV Cube A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1671605654', NULL, N'LU6624', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (199, CAST(N'2017-09-29T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Cube Z EUR', N'Multi Stars SICAV Cube Z EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 1, NULL, NULL, NULL, N'LU1671606116', NULL, N'LU6624', NULL, NULL, NULL, N'Z', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (200, CAST(N'2017-09-29T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Cube S EUR', N'Multi Stars SICAV Cube S EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2017-12-01T00:00:00.000' AS DateTime), CAST(N'2017-12-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1671606389', NULL, N'LU6624', NULL, NULL, NULL, N'S', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (201, CAST(N'2015-12-31T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Regent Serenity Fund DH EUR', N'Multi Stars SICAV Regent Serenity Fund DH EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2016-01-28T00:00:00.000' AS DateTime), CAST(N'2016-01-28T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 1, 0, NULL, NULL, NULL, N'LU1333049911', NULL, N'LU6406', NULL, NULL, NULL, N'DH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (202, CAST(N'2015-12-31T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Regent Serenity Fund CH EUR', N'Multi Stars SICAV Regent Serenity Fund CH EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2016-01-28T00:00:00.000' AS DateTime), CAST(N'2016-01-28T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C4', 1, 0, NULL, NULL, NULL, N'LU1333050091', NULL, N'LU6406', NULL, NULL, NULL, N'CH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (203, CAST(N'2015-01-30T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Regent Serenity Fund A GBP', N'Multi Stars SICAV Regent Serenity Fund A GBP', 1, 1, N'GBP', NULL, NULL, CAST(N'2015-02-05T00:00:00.000' AS DateTime), CAST(N'2015-02-05T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C2', 0, 0, NULL, NULL, NULL, N'LU1172430958', NULL, N'LU6406', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (204, CAST(N'2014-10-30T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Regent Serenity Fund B GBP', N'Multi Stars SICAV Regent Serenity Fund B GBP', 4, 1, N'GBP', NULL, NULL, CAST(N'2014-10-30T00:00:00.000' AS DateTime), CAST(N'2014-10-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1118191490', NULL, N'LU6406', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (205, CAST(N'2014-10-21T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Alexander A EUR', N'Multi Stars SICAV Alexander A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2014-10-21T00:00:00.000' AS DateTime), CAST(N'2014-10-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU1110447759', NULL, N'LU6389', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (206, CAST(N'2014-08-25T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Emerging Market Local Currency FHD USD', N'Multi Stars SICAV Emerging Market Local Currency FHD USD', 4, 2, N'USD', NULL, NULL, CAST(N'2014-08-25T00:00:00.000' AS DateTime), CAST(N'2014-08-25T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D3', 1, 0, NULL, NULL, NULL, N'LU1095738685', NULL, N'LU6276', NULL, NULL, NULL, N'FHD', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (207, CAST(N'2013-09-02T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Sureco US Core Equity A USD', N'Multi Stars SICAV Sureco US Core Equity A USD', 1, 1, N'USD', NULL, NULL, CAST(N'2013-09-02T00:00:00.000' AS DateTime), CAST(N'2013-09-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0961060687', NULL, N'LU6304', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (208, CAST(N'2013-08-06T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Emerging Market Local Currency AD EUR', N'Multi Stars SICAV Emerging Market Local Currency AD EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2013-08-06T00:00:00.000' AS DateTime), CAST(N'2013-08-06T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D1', 0, 0, NULL, NULL, NULL, N'LU0950572924', NULL, N'LU6276', NULL, NULL, NULL, N'AD', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (209, CAST(N'2013-08-06T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Emerging Market Local Currency BD EUR', N'Multi Stars SICAV Emerging Market Local Currency BD EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2013-08-06T00:00:00.000' AS DateTime), CAST(N'2013-08-06T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'D2', 0, 0, NULL, NULL, NULL, N'LU0950573062', NULL, N'LU6276', NULL, NULL, NULL, N'BD', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (210, CAST(N'2013-08-05T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Cefisa Relative Strength EU Equity A EUR', N'Multi Stars SICAV Cefisa Relative Strength EU Equity A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2013-08-05T00:00:00.000' AS DateTime), CAST(N'2013-08-05T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0950572684', NULL, N'LU6274', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (211, CAST(N'2013-08-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV Cefisa Relative Strength Global Asset Allocation A EUR', N'Multi Stars SICAV Cefisa Relative Strength Global Asset Allocation A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2013-08-01T00:00:00.000' AS DateTime), CAST(N'2013-08-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, NULL, NULL, NULL, NULL, N'LU0950572767', NULL, N'LU6275', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (212, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-11-14T00:00:00.000' AS DateTime), N'Multi Stars SICAV - AL-FA Dynamic A EUR', N'Multi Stars SICAV - AL-FA Dynamic A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-08-20T00:00:00.000' AS DateTime), CAST(N'2012-08-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0809734113', NULL, N'LU6266', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (212, CAST(N'2019-11-15T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV AL-FA Sustainable Megatrends A EUR', N'Multi Stars SICAV AL-FA Sustainable Megatrends A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2012-08-20T00:00:00.000' AS DateTime), CAST(N'2012-08-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU0809734113', NULL, N'LU6266', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (213, CAST(N'2018-03-12T00:00:00.000' AS DateTime), NULL, N'United SICAV-RAIF Market Neutral Actions Euro P EUR', N'United SICAV-RAIF Market Neutral Actions Euro P EUR', 5, 1, N'EUR', NULL, NULL, CAST(N'2018-04-27T00:00:00.000' AS DateTime), CAST(N'2018-04-27T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C3', 0, 0, NULL, NULL, NULL, N'LU1805040109', NULL, N'1826', NULL, NULL, NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (214, CAST(N'2017-07-19T00:00:00.000' AS DateTime), CAST(N'2019-12-17T00:00:00.000' AS DateTime), N'Ritom Sicav Raif - Peak Fund A', N'Ritom Sicav Raif - Peak Fund A', 5, 1, N'EUR', NULL, NULL, CAST(N'2017-08-07T00:00:00.000' AS DateTime), CAST(N'2017-08-07T00:00:00.000' AS DateTime), NULL, NULL, 2, 100, N'CA', 0, 0, NULL, NULL, NULL, N'LU1654544995', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (215, CAST(N'2017-07-19T00:00:00.000' AS DateTime), CAST(N'2018-07-03T00:00:00.000' AS DateTime), N'Ritom Sicav Raif - Peak Fund B', N'Ritom Sicav Raif - Peak Fund B', 5, 1, N'EUR', NULL, NULL, CAST(N'2017-12-11T00:00:00.000' AS DateTime), CAST(N'2017-12-11T00:00:00.000' AS DateTime), NULL, NULL, 3, 100, N'CB', 0, 0, NULL, NULL, NULL, N'LU1654545026', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (216, CAST(N'2017-02-28T00:00:00.000' AS DateTime), NULL, N'Bright Stars Sicav Vitalix A', N'Bright Stars Sicav Vitalix A', 5, 1, N'USD', NULL, NULL, CAST(N'2017-06-30T00:00:00.000' AS DateTime), CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, N'C1', 0, 0, NULL, NULL, NULL, N'LU1485530684', NULL, N'LU6542', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (217, CAST(N'2018-03-12T00:00:00.000' AS DateTime), NULL, N'United SICAV-RAIF Market Neutral Actions Euro A EUR', N'United SICAV-RAIF Market Neutral Actions Euro A EUR', 5, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1805039945', NULL, N'1826', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (218, CAST(N'2018-03-12T00:00:00.000' AS DateTime), NULL, N'United SICAV-RAIF Market Neutral Actions Euro B EUR', N'United SICAV-RAIF Market Neutral Actions Euro B EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1805040018', NULL, N'1826', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (219, CAST(N'2018-03-12T00:00:00.000' AS DateTime), NULL, N'United SICAV-RAIF Market Neutral Actions Euro S EUR', N'United SICAV-RAIF Market Neutral Actions Euro S EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1805040281', NULL, N'1826', NULL, NULL, NULL, N'S', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (220, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Athena Balanced I', N'1st SICAV Athena Balanced I', 4, 1, N'EUR', NULL, NULL, CAST(N'2017-01-03T00:00:00.000' AS DateTime), CAST(N'2018-04-10T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1435778482', NULL, N'30658', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (221, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Hestia Conservative I', N'1st SICAV Hestia Conservative I', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1435778649', NULL, N'30659', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (222, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV Italy S', N'1st SICAV Italy S', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1435777757', NULL, N'30656', NULL, NULL, NULL, N'S', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (223, CAST(N'2015-03-25T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond I CHF', N'GFG Funds Euro Global Bond I CHF', NULL, NULL, N'CHF', NULL, NULL, CAST(N'2015-03-25T00:00:00.000' AS DateTime), CAST(N'2015-03-25T00:00:00.000' AS DateTime), NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1196450693', NULL, N'51115', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (224, CAST(N'2015-03-23T00:00:00.000' AS DateTime), NULL, N'GFG Funds Euro Global Bond PP CHF', N'GFG Funds Euro Global Bond PP CHF', NULL, NULL, N'CHF', NULL, NULL, CAST(N'2015-03-23T00:00:00.000' AS DateTime), CAST(N'2015-03-23T00:00:00.000' AS DateTime), NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1196450420', NULL, N'51115', NULL, NULL, NULL, N'PP', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (225, CAST(N'2019-04-17T00:00:00.000' AS DateTime), NULL, N'GFG Funds Global Corporate Bond I EUR', N'GFG Funds Global Corporate Bond I EUR', 4, NULL, N'EUR', NULL, NULL, CAST(N'2019-04-17T00:00:00.000' AS DateTime), CAST(N'2019-11-29T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1981743195', NULL, N'38123', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (226, CAST(N'2019-04-17T00:00:00.000' AS DateTime), NULL, N'GFG Funds Global Corporate Bond P EUR', N'GFG Funds Global Corporate Bond P EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1981743278', NULL, N'38123', NULL, NULL, NULL, N'P', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (227, CAST(N'2019-04-17T00:00:00.000' AS DateTime), NULL, N'GFG Funds Global Corporate Bond PP EUR', N'GFG Funds Global Corporate Bond PP EUR', 1, NULL, N'EUR', NULL, NULL, CAST(N'2019-04-17T00:00:00.000' AS DateTime), CAST(N'2019-11-29T00:00:00.000' AS DateTime), NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1981743351', NULL, N'38123', NULL, NULL, NULL, N'PP', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (228, CAST(N'2017-03-23T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV FLexible Credit A CHF', N'Kite Fund SICAV FLexible Credit A CHF', NULL, NULL, N'CHF', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1550130956', NULL, N'26886', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (229, CAST(N'2017-03-23T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV FLexible Credit A USD', N'Kite Fund SICAV FLexible Credit A USD', NULL, NULL, N'USD', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1550131509', NULL, N'26886', NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (230, CAST(N'2017-03-23T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV FLexible Credit I', N'Kite Fund SICAV FLexible Credit I', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1550131251', NULL, N'26886', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (231, CAST(N'2016-07-11T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Avantgarde E USD', N'Pharus Sicav Avantgarde E USD', NULL, NULL, N'USD', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1882537845', NULL, NULL, NULL, NULL, NULL, N'E', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (232, CAST(N'2009-11-30T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Global Flexible Bond D CHF', N'Pharus Sicav Global Flexible Bond D CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2019-12-20T00:00:00.000' AS DateTime), CAST(N'2019-12-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU2081626249', NULL, NULL, NULL, NULL, NULL, N'D', N'change the name of Class D into BH-CHF', N'CHANGE THE NAME OF CLASS D INTO BH-CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (232, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Flexible Bond BH CHF', N'Pharus Sicav Global Flexible Bond BH CHF', 4, 1, N'CHF', NULL, NULL, CAST(N'2019-12-20T00:00:00.000' AS DateTime), CAST(N'2019-12-20T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU2081626249', NULL, N'BHCHF', NULL, NULL, NULL, N'BH', N'change the name of Class D into BH-CHF', N'CHANGE THE NAME OF CLASS D INTO BH-CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (233, CAST(N'2009-11-30T00:00:00.000' AS DateTime), CAST(N'2020-10-21T00:00:00.000' AS DateTime), N'Pharus Sicav Global Flexible Bond Z EUR', N'Pharus Sicav Global Flexible Bond Z EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 1, NULL, NULL, NULL, N'LU2012056466', NULL, NULL, NULL, NULL, NULL, N'Z', N'ACTIVATED ON 22/10/2020', N'ACTIVATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (233, CAST(N'2020-10-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Flexible Bond Z EUR', N'Pharus Sicav Global Flexible Bond Z EUR', 6, 1, N'EUR', N'LU', NULL, CAST(N'2009-11-30T00:00:00.000' AS DateTime), CAST(N'2020-10-22T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 1, NULL, NULL, NULL, N'LU2012056466', NULL, N'Z', NULL, NULL, NULL, N'Z', N'ACTIVATED ON 22/10/2020', N'ACTIVATED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (234, CAST(N'2009-11-30T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Global Flexible Bond B EUR', N'Pharus Sicav Global Flexible Bond B EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU2081626165', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (235, CAST(N'2018-08-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Electric Mobility Niches A EUR', N'Pharus Sicav Electric Mobility Niches A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2019-10-23T00:00:00.000' AS DateTime), CAST(N'2019-10-23T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1867072149', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (236, CAST(N'2018-08-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Electric Mobility Niches B EUR', N'Pharus Sicav Electric Mobility Niches B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2019-06-07T00:00:00.000' AS DateTime), CAST(N'2019-06-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1867072222', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (237, CAST(N'2018-08-22T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Electric Mobility Niches Q EUR', N'Pharus Sicav Electric Mobility Niches Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2019-06-07T00:00:00.000' AS DateTime), CAST(N'2019-06-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 1, NULL, NULL, NULL, N'LU1867072495', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (238, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Asian Niches B EUR', N'Pharus Sicav Asian Niches B EUR', 4, 1, N'EUR', NULL, NULL, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1867072651', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (239, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Asian Niches A EUR', N'Pharus Sicav Asian Niches A EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1867072578', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (240, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Asian Niches Q EUR', N'Pharus Sicav Asian Niches Q EUR', 1, 1, N'EUR', NULL, NULL, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 1, NULL, NULL, NULL, N'LU1867072735', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (241, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend A EUR', N'Pharus SICAV - Target Equity Dividend A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872042', NULL, NULL, NULL, NULL, NULL, N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (241, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies A EUR', N'Pharus Sicav Best Regulated Companies A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872042', NULL, NULL, NULL, NULL, NULL, N'A', N'CHANGED FROM A TO AD', N'CHANGED FROM A TO AD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (241, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies AD EUR', N'Pharus Sicav Best Regulated Companies AD EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872042', NULL, N'AD', NULL, NULL, NULL, N'AD', N'CHANGED FROM A TO AD', N'CHANGED FROM A TO AD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (242, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend B EUR', N'Pharus SICAV - Target Equity Dividend B EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872125', NULL, NULL, NULL, NULL, NULL, N'B', NULL, NULL)
GO
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (242, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies B EUR', N'Pharus Sicav Best Regulated Companies B EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872125', NULL, NULL, NULL, NULL, NULL, N'B', N'CHANGED FROM B TO BD', N'CHANGED FROM B TO BD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (242, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies BD EUR', N'Pharus Sicav Best Regulated Companies BD EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872125', NULL, N'BD', NULL, NULL, NULL, N'BD', N'CHANGED FROM B TO BD', N'CHANGED FROM B TO BD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (243, CAST(N'2019-01-02T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies C EUR', N'Pharus Sicav Best Regulated Companies C EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872398', NULL, NULL, NULL, NULL, NULL, N'C', N'CHANGED FROM C EUR TO BHD USD', N'CHANGED FROM C EUR TO BHD USD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (243, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies BHD USD', N'Pharus Sicav Best Regulated Companies BHD USD', NULL, NULL, N'USD', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872398', NULL, N'BHDUSD', NULL, NULL, NULL, N'BHD', N'CHANGED FROM C EUR TO BHD USD', N'CHANGED FROM C EUR TO BHD USD')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (244, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend E CHF', N'Pharus SICAV - Target Equity Dividend E CHF', 1, 2, N'CHF', NULL, NULL, CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU1868872471', NULL, NULL, NULL, NULL, NULL, N'E', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (244, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies E CHF', N'Pharus Sicav Best Regulated Companies E CHF', 1, 2, N'CHF', NULL, NULL, CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU1868872471', NULL, NULL, NULL, NULL, NULL, N'E', N'class E becomes class AHD - CHF', N'CLASS E BECOMES CLASS AHD - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (244, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies AHD CHF', N'Pharus Sicav Best Regulated Companies AHD CHF', 1, 2, N'CHF', NULL, NULL, CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU1868872471', NULL, N'AHDCHF', NULL, NULL, NULL, N'AHD', N'class E becomes class AHD - CHF', N'CLASS E BECOMES CLASS AHD - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (245, CAST(N'2019-01-02T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies F EUR', N'Pharus Sicav Best Regulated Companies F EUR', NULL, NULL, N'EUR', NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872554', NULL, NULL, NULL, NULL, NULL, N'F', N'Class F becomes class BHD - CHF', N'CLASS F BECOMES CLASS BHD - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (245, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies BHD CHF', N'Pharus Sicav Best Regulated Companies BHD CHF', NULL, NULL, N'CHF', NULL, NULL, NULL, NULL, NULL, NULL, 4, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872554', NULL, N'BHDCHF', NULL, NULL, NULL, N'BHD', N'Class F becomes class BHD - CHF', N'CLASS F BECOMES CLASS BHD - CHF')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (246, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend G EUR', N'Pharus SICAV - Target Equity Dividend G EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872638', NULL, NULL, NULL, NULL, NULL, N'G', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (246, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies G EUR', N'Pharus Sicav Best Regulated Companies G EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872638', NULL, NULL, NULL, NULL, NULL, N'G', N'CLASS G BECOMES CLASS A', N'CLASS G BECOMES CLASS A')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (246, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies A EUR', N'Pharus Sicav Best Regulated Companies A EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872638', NULL, N'AEUR', NULL, NULL, NULL, N'A', N'CLASS G BECOMES CLASS A', N'CLASS G BECOMES CLASS A')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (247, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend H EUR', N'Pharus SICAV - Target Equity Dividend H EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872711', NULL, NULL, NULL, NULL, NULL, N'H', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (247, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus Sicav Best Regulated Companies H EUR', N'Pharus Sicav Best Regulated Companies H EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872711', NULL, NULL, NULL, NULL, NULL, N'H', N'CLASS H BECOMES CLASS B', N'CLASS H BECOMES CLASS B')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (247, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies B EUR', N'Pharus Sicav Best Regulated Companies B EUR', 4, 2, N'EUR', NULL, NULL, CAST(N'2019-03-29T00:00:00.000' AS DateTime), CAST(N'2019-03-29T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU1868872711', NULL, N'BEUR', NULL, NULL, NULL, N'B', N'CLASS H BECOMES CLASS B', N'CLASS H BECOMES CLASS B')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (248, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend Q EUR', N'Pharus SICAV - Target Equity Dividend Q EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-07-08T00:00:00.000' AS DateTime), CAST(N'2019-07-08T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 1, NULL, NULL, NULL, N'LU1868872802', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (248, CAST(N'2019-12-16T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies Q EUR', N'Pharus Sicav Best Regulated Companies Q EUR', 1, 2, N'EUR', NULL, NULL, CAST(N'2019-07-08T00:00:00.000' AS DateTime), CAST(N'2019-07-08T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 0, 1, NULL, NULL, NULL, N'LU1868872802', NULL, NULL, NULL, NULL, NULL, N'Q', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (249, CAST(N'2019-12-18T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Fasanara Quant BH', N'Pharus Sicav Fasanara Quant BH', 4, NULL, N'USD', N'LU', NULL, CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 100, NULL, 1, 0, NULL, NULL, NULL, N'LU2040055670', NULL, N'402', NULL, NULL, NULL, N'BH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (250, CAST(N'2019-12-18T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Fasanara Quant B', N'Pharus Sicav Fasanara Quant B', 4, NULL, N'EUR', N'LU', NULL, NULL, CAST(N'2020-06-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 0, NULL, 0, 0, NULL, NULL, NULL, N'LU2040055241', NULL, N'402B', NULL, NULL, NULL, N'B', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (251, CAST(N'2019-12-18T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Fasanara Quant B1', N'Pharus Sicav Fasanara Quant B1', 4, NULL, N'EUR', N'LU', NULL, CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-12T00:00:00.000' AS DateTime), NULL, NULL, 1, 0, NULL, 0, 0, NULL, NULL, NULL, N'LU2040055324', NULL, N'402B1', NULL, NULL, NULL, N'B1', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (252, CAST(N'2019-12-18T00:00:00.000' AS DateTime), CAST(N'2020-07-14T00:00:00.000' AS DateTime), N'Pharus Sicav Fasanara Quant A', N'Pharus Sicav Fasanara Quant A', 1, NULL, N'EUR', N'LU', N'LU', NULL, NULL, NULL, NULL, 4, 100, NULL, 0, 0, NULL, NULL, NULL, N'LU2040055167', NULL, N'402A', NULL, NULL, NULL, N'A', N'launched', N'LAUNCHED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (252, CAST(N'2020-07-15T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Fasanara Quant A', N'Pharus Sicav Fasanara Quant A', 1, NULL, N'EUR', NULL, NULL, CAST(N'2020-07-15T00:00:00.000' AS DateTime), CAST(N'2020-07-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 0, NULL, 0, 0, NULL, NULL, NULL, N'LU2040055167', NULL, N'402A', NULL, NULL, NULL, N'A', N'launched', N'LAUNCHED')
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (253, CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL, N'MH Fund SICAV SIF Vitalis Equity-Lux Fd A USD', N'MH Fund SICAV SIF Vitalis Equity-Lux Fd A USD', 5, NULL, N'USD', N'LU', N'LU', NULL, NULL, NULL, NULL, 1, 100, N'D1', 0, 0, N'LX', N'VITEQYA LX', NULL, N'LU1554402526', NULL, N'LU6793A', N'LU6793A', NULL, CAST(N'2020-12-31T00:00:00.000' AS DateTime), N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (254, CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL, N'MH Fund SICAV SIF Vitalis Fixed Income-Lux Fd A USD', N'MH Fund SICAV SIF Vitalis Fixed Income-Lux Fd A USD', 5, NULL, N'USD', N'LU', N'LU', NULL, NULL, NULL, NULL, 1, 0, N'D1', 0, 0, N'LX', N'VITFXIA LX', NULL, N'LU1554410974', NULL, N'LU6794A', N'LU6794A', NULL, CAST(N'2020-08-31T00:00:00.000' AS DateTime), N'A', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (255, CAST(N'2020-09-04T00:00:00.000' AS DateTime), NULL, N'Emerald Euro Government Bond R EUR ACC', N'Emerald Euro Government Bond R EUR ACC', 2, NULL, N'EUR', N'LU', N'LU', NULL, NULL, NULL, NULL, 4, 100, N'R', 0, 0, NULL, NULL, NULL, N'LU2186178591', NULL, N'26056R', NULL, NULL, NULL, N'R', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (256, CAST(N'2020-09-04T00:00:00.000' AS DateTime), NULL, N'Emerald Euro Government Bond RR EUR ACC', N'Emerald Euro Government Bond RR EUR ACC', 1, NULL, N'EUR', N'LU', N'LU', NULL, NULL, NULL, NULL, 4, 100, N'RR', 0, 0, NULL, NULL, NULL, N'LU2186178674', NULL, N'26056RR', NULL, NULL, NULL, N'RR', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (257, CAST(N'2020-09-04T00:00:00.000' AS DateTime), NULL, N'Emerald Euro Government Bond I EUR ACC', N'Emerald Euro Government Bond I EUR ACC', 4, NULL, N'EUR', N'LU', N'LU', NULL, NULL, NULL, NULL, 4, 100, N'I', 0, 0, NULL, NULL, NULL, N'LU2186178757', NULL, N'26056I', NULL, NULL, NULL, N'I', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (258, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Best Regulated Companies AH AUD', N'Pharus Sicav Best Regulated Companies AH AUD', 1, NULL, N'AUD', N'LU', NULL, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, NULL, NULL, 4, 100, NULL, 1, 0, NULL, NULL, NULL, N'TBDAHAUD    ', NULL, N'AHAUD', NULL, NULL, NULL, N'AH', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (259, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Fasanara Quant B2', N'Pharus Sicav Fasanara Quant B2', 4, NULL, N'EUR', N'LU', NULL, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, NULL, NULL, 4, 100, N'B2', 0, 0, NULL, NULL, NULL, N'LU2040055597', NULL, N'B2', NULL, NULL, NULL, N'B2', NULL, NULL)
INSERT [dbo].[tb_historyShareClass] ([sc_id], [sc_initialDate], [sc_endDate], [sc_officialShareClassName], [sc_shortShareClassName], [sc_investorType], [sc_shareType], [sc_currency], [sc_countryIssue], [sc_ultimateParentCountryRisk], [sc_emissionDate], [sc_inceptionDate], [sc_lastNav], [sc_expiryDate], [sc_status], [sc_initialPrice], [sc_accountingCode], [sc_hedged], [sc_listed], [sc_bloomberMarket], [sc_bloombedCode], [sc_bloombedId], [sc_isinCode], [sc_valorCode], [sc_faCode], [sc_taCode], [sc_WKN], [sc_date_business_year], [sc_prospectus_code], [sc_change_comment], [sc_comment_title]) VALUES (260, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, N'Pharus Sicav Target AH AUD', N'Pharus Sicav Target AH AUD', 1, NULL, N'AUD', N'LU', NULL, CAST(N'2020-12-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, 4, 100, N'AH', 1, 0, NULL, NULL, NULL, N'TBDAHAUD    ', NULL, N'AHAUD', NULL, NULL, NULL, N'AH', NULL, NULL)
GO
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (1, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV - Athena Balanced', N'1st SICAV - Athena Balanced', N'O00011081_00000005', N'30658', N'47156', N'30658', NULL, NULL, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, 1, N'	 222100P3F8MWHFBFOX70', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 1, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV - Hestia Conservative', N'1st SICAV - Hestia Conservative', N'O00011081_00000006', N'30659', N'47157', N'30659', NULL, NULL, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, 1, N'222100GXXV9PYXJ5EJ61', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 3, 1, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (3, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'1st SICAV - Italy', N'1st SICAV - Italy', N'O00011081_00000003', N'30656', N'47153', N'30656', NULL, NULL, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, 1, N'	 2221006GBQ7E4OLHMI55', NULL, 3, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 OWM01', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (4, CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, N'Bright Stars SICAV-SIF - VITALIX', N'Bright Stars SICAV-SIF - VITALIX', N'O00011020_00000001', N'LU6542', N'5445270', N'LU6542', NULL, NULL, CAST(N'2018-12-18T00:00:00.000' AS DateTime), NULL, 1, N'	 5299001531N4FD5B2392', NULL, NULL, 4, N'USD', 4, 8, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (5, CAST(N'2011-07-14T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Euro Global Bond', N'Efficiency Growth Fund - Euro Global Bond', N'O00002118_00000010', N'51115', N'51115', N'51115', NULL, NULL, CAST(N'2011-05-03T00:00:00.000' AS DateTime), NULL, 1, N'529900DAOBBDCY8NV798', NULL, NULL, NULL, N'EUR', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, N'FUND NAME CHANGE')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (5, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds - Euro Global Bond', N'GFG Funds - Euro Global Bond', N'O00002118_00000010', N'51115', N'51115', N'51115                                                                                               ', NULL, NULL, CAST(N'2011-05-03T00:00:00.000' AS DateTime), NULL, 1, N'529900DAOBBDCY8NV798', NULL, 3, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 2, 1, 1, NULL, NULL, NULL, 1, NULL, N'FUND NAME CHANGE')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (6, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-08-12T00:00:00.000' AS DateTime), N'Efficiency Growth Fund - Income Opportunity', N'Efficiency Growth Fund - Income Opportunity', N'O00002118_00000013', N'33646', N'33646', N'33646', NULL, NULL, CAST(N'2017-04-25T00:00:00.000' AS DateTime), NULL, 1, N'529900MI16EB9MJ6SX85', NULL, NULL, 1, N'EUR', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, N'FUND NAME CHANGED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (6, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds - Income Opportunity', N'GFG Funds - Income Opportunity', N'O00002118_00000013', N'33646', N'33646', N'33646                                                                                               ', NULL, NULL, CAST(N'2017-04-25T00:00:00.000' AS DateTime), NULL, 1, N'	 529900MI16EB9MJ6SX85', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 3, NULL, NULL, NULL, 2, NULL, N'FUND NAME CHANGED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (7, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Emerald Euro Inflation Linked Bond', N'Emerald Euro Inflation Linked Bond', N'O00008724_00000002', N'88057', N'88057', N'88057', NULL, NULL, CAST(N'2017-12-12T00:00:00.000' AS DateTime), NULL, 1, N'	 529900AE72FS7KYGHW03', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 2, 1, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (8, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Emerald Euro Investment Grade Bond', N'Emerald Euro Investment Grade Bond', N'O00008724_00000001', N'8062', N'8062', N'8062', NULL, NULL, CAST(N'2017-11-17T00:00:00.000' AS DateTime), NULL, 1, N'	 529900DCGVVZHKM6F683', NULL, 3, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 2, 1, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (9, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV - Kite Flexible Credit', N'Kite Fund SICAV - Kite Flexible Credit', N'O00007630_00000002', N'26886', N'45122', N'26886', NULL, NULL, CAST(N'2017-03-23T00:00:00.000' AS DateTime), NULL, 1, N'	 222100QIEEYRDO22BT02', NULL, 6, 3, N'EUR', 1, 9, 2, NULL, NULL, NULL, NULL, NULL, 4, 1, 1, N'79683', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (10, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Kite Fund SICAV - Total Return', N'Kite Fund SICAV - Total Return', N'O00007630_00000001', N'22132', N'45121', N'22132', NULL, NULL, CAST(N'2012-09-25T00:00:00.000' AS DateTime), NULL, 1, N'	 529900WLOFHVZK7J4G22', NULL, 6, 3, N'EUR', 1, 9, 2, NULL, NULL, NULL, NULL, NULL, 11, 1, 1, N'99812', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (11, CAST(N'2014-10-21T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Alexander', N'Multi Stars SICAV - Alexander', N'O00007588_00000009', N'LU6389', N'5443740', N'LU6389', NULL, NULL, CAST(N'2014-08-28T00:00:00.000' AS DateTime), NULL, 1, N'	 529900A0YNWHVW0S6496', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 11, 1, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (12, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-11-14T00:00:00.000' AS DateTime), N'Multi Stars SICAV - AL-FA Dynamic', N'Multi Stars SICAV - AL-FA Dynamic', N'O00007588_00000003', N'LU6266', N'5001200', N'LU6266', NULL, NULL, CAST(N'2012-07-23T00:00:00.000' AS DateTime), NULL, 1, N'5299003CF4QLJUYYPU03', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 11, 3, 1, NULL, NULL, NULL, 2, N'ex. AL-FA Dynamic', N'CHANGED NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (12, CAST(N'2019-11-15T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - AL-FA Sustainable Megatrends', N'Multi Stars SICAV - AL-FA Sustainable Megatrends', N'O00007588_00000003', N'LU6266', N'5001200', N'LU6266                                                                                              ', NULL, NULL, CAST(N'2012-07-23T00:00:00.000' AS DateTime), NULL, 1, N'5299003CF4QLJUYYPU03', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, NULL, NULL, NULL, 2, N'ex. AL-FA Dynamic', N'CHANGED NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (13, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Amares Strategy Fund - Balanced', N'Multi Stars SICAV - Amares Strategy Fund - Balanced', N'O00007588_00000014', N'LU6714', N'5446850', N'LU6714', NULL, NULL, CAST(N'2018-12-14T00:00:00.000' AS DateTime), NULL, 1, N'	 529900GN12WQWWPSOR02', NULL, 6, 3, N'EUR', 2, 3, 1, 0, NULL, NULL, NULL, NULL, 11, 1, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (14, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Cefisa Relative Strenght European Equity', N'Multi Stars SICAV - Cefisa Relative Strenght European Equity', N'O00007588_00000005', N'LU6274', N'5442590', N'LU6274', NULL, NULL, CAST(N'2013-06-26T00:00:00.000' AS DateTime), NULL, 1, N'	 529900E3WLKUC0Y3AI53', NULL, 3, 3, N'EUR', 2, 1, 1, 0, NULL, NULL, NULL, NULL, 12, 1, 1, NULL, NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (15, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Cefisa Relative Strenght Global Asset Allocation', N'Multi Stars SICAV - Cefisa Relative Strenght Global Asset Allocation', N'O00007588_00000006', N'LU6275', N'5442600', N'LU6275', NULL, NULL, CAST(N'2013-06-26T00:00:00.000' AS DateTime), NULL, 1, N'	 529900COCSGVBUL0UZ80', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 12, 1, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (16, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - CUBE', N'Multi Stars Sicav - CUBE', N'O00007588_00000012', N'LU6624', N'5446090', N'LU6624', NULL, NULL, CAST(N'2017-08-25T00:00:00.000' AS DateTime), NULL, 1, N'529900LOIBDHYJLQ0T30', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 11, 1, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (17, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - HEarth ETHICAL FUND', N'Multi Stars Sicav - HEarth ETHICAL FUND', N'O00007588_00000013', N'LU6658', N'5446340', N'LU6658', NULL, NULL, CAST(N'2017-10-18T00:00:00.000' AS DateTime), NULL, 1, N'	 529900BD1ZUS0MTPY974', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 11, 3, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (18, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Regent Serenity Fund', N'Multi Stars SICAV - Regent Serenity Fund', N'O00007588_00000010', N'LU6406', N'5443910', N'LU6406', NULL, NULL, CAST(N'2014-09-19T00:00:00.000' AS DateTime), NULL, 1, N'	 529900HLR6PAJW6NNT41', NULL, 6, 3, N'GBP', 2, 4, 1, NULL, NULL, NULL, NULL, NULL, 11, 1, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (19, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Sureco US Core Equity', N'Multi Stars SICAV - Sureco US Core Equity', N'O00007588_00000008', N'LU6304', N'5442890', N'LU6304', NULL, NULL, CAST(N'2013-07-26T00:00:00.000' AS DateTime), NULL, 1, N'	 529900KRKQKFR52A6V34', NULL, 4, 3, N'USD', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (20, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Emerging Market Local Currency', N'Multi Stars SICAV - Emerging Market Local Currency', N'O00007588_00000007', N'LU6276', N'5442610', N'LU6276', NULL, NULL, CAST(N'2013-06-26T00:00:00.000' AS DateTime), NULL, 1, N'	 5299007JJDINAVGKJN23', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 2, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (21, CAST(N'2007-04-15T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus SICAV - Absolute Return', N'Pharus SICAV - Absolute Return', N'O00003465_00000008', N'19693', N'40495', N'19693', NULL, NULL, CAST(N'2004-08-04T00:00:00.000' AS DateTime), NULL, 1, N'549300OGZCRIA3VCSR93', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, 3, 1, N'8 200 PDG35', NULL, NULL, 2, N'PHARUS SICAV – ABSOLUTE RETURN changed the name of the sub-fund to Pharus SICAV – Conservative.

increase the minimum holding amount for share Class B from EUR 1,000 to EUR 100,000.', N'NAME CHANGE')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (21, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV – Conservative', N'Pharus SICAV – Conservative', N'O00003465_00000008', N'19693', N'40495', N'19693                                                                                               ', NULL, NULL, CAST(N'2004-08-04T00:00:00.000' AS DateTime), NULL, 1, N'549300OGZCRIA3VCSR93', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, NULL, NULL, N'8200PDG35                                                                                           ', NULL, NULL, 2, N'PHARUS SICAV – ABSOLUTE RETURN changed the name of the sub-fund to Pharus SICAV – Conservative.

increase the minimum holding amount for share Class B from EUR 1,000 to EUR 100,000.', N'NAME CHANGE')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (22, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Algo Flex', N'Pharus SICAV - Algo Flex', N'O00003465_00000027', N'19663', N'40463', N'19663', NULL, NULL, CAST(N'2012-02-02T00:00:00.000' AS DateTime), NULL, 1, N'	 5493002NLFW4QBPHI238', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, N'8 200 PDG34', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (23, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), N'Pharus SICAV - Asian Niches', N'Pharus SICAV - Asian Niches', N'O00003465_00000054', N'4545', N'44754', N'4545', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 4, N'	 549300RXJLJ47ZY3ZL19', NULL, 2, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 1, 3, 1, NULL, NULL, NULL, 2, NULL, N'SUB FUND LAUNCH')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (23, CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Asian Niches', N'Pharus SICAV - Asian Niches', N'O00003465_00000054', N'4545', N'44754', N'4545', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 1, N'	 549300RXJLJ47ZY3ZL19', NULL, 2, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 3, 1, NULL, NULL, NULL, 2, NULL, N'SUB FUND LAUNCH')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (24, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Athesis Total Return', N'Pharus SICAV - Athesis Total Return', N'O00003465_00000045', N'9901', N'41783', N'9901', NULL, NULL, CAST(N'2016-05-02T00:00:00.000' AS DateTime), NULL, 1, N'	 222100SYTJNZIWAPUA25', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 1, 1, N'8 200 PDG20', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (25, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Avantgarde', N'Pharus SICAV - Avantgarde', N'O00003465_00000048', N'15324', N'47394', N'15324', NULL, NULL, CAST(N'2016-07-11T00:00:00.000' AS DateTime), NULL, 1, N'22210002OFQ9S3U35E97', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 12, 1, 3, N'8 200 PDG10', NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (26, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-07-30T00:00:00.000' AS DateTime), N'Pharus SICAV - Best Global Managers Flexible Equity', N'Pharus SICAV - Best Global Managers Flexible Equity', N'O00003465_00000024', N'19658', N'40458', N'19658', NULL, NULL, NULL, NULL, 1, N'	 549300FII8TS79ZZ6V77', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, N'8 200 PDG47', NULL, NULL, 2, NULL, N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (26, CAST(N'2019-07-31T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Best Global Managers Flexible Equity', N'Pharus SICAV - Best Global Managers Flexible Equity', N'O00003465_00000024', N'19658', N'40458', N'19658                                                                                               ', NULL, NULL, NULL, NULL, 3, N'549300FII8TS79ZZ6V77', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, N'8 200 PDG47', NULL, NULL, 2, NULL, N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (27, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), N'Pharus SICAV - Biotech', N'Pharus SICAV  - Biotech', N'O00003465_00000049', N'17389', N'47395', N'17389', NULL, NULL, CAST(N'2016-08-23T00:00:00.000' AS DateTime), NULL, 1, N'	 2221001XBCEZX0P1WC88', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG09', NULL, NULL, 8, N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (27, CAST(N'2020-11-19T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Medical Innovation', N'Pharus SICAV - Medical Innovation', N'O00003465_00000049', N'17389', N'47395', N'17389                                                                                               ', NULL, NULL, CAST(N'2016-08-23T00:00:00.000' AS DateTime), NULL, 1, N'	 2221001XBCEZX0P1WC88', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, NULL, NULL, N'8200PDG09                                                                                           ', NULL, NULL, 8, N'CHANGED NAME', N'CHANGED NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (28, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Bond Opportunities', N'Pharus SICAV - Bond Opportunities', N'O00003465_00000005', N'19670', N'40475', N'19670', NULL, NULL, CAST(N'2002-12-05T00:00:00.000' AS DateTime), NULL, 1, N'	 549300R6URP1GY5YYF05', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, 3, 1, N'8 200 PDG43', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (29, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2020-03-04T00:00:00.000' AS DateTime), N'Pharus SICAV - Bond Value', N'Pharus SICAV - Bond Value', N'O00003465_00000050', N'17390', N'47396', N'17390', NULL, NULL, CAST(N'2017-02-09T00:00:00.000' AS DateTime), NULL, 1, N'	 222100ZVEE1SLAL6RB69', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 4, 3, 1, NULL, NULL, NULL, 1, N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (29, CAST(N'2020-03-05T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Bond Value', N'Pharus SICAV - Bond Value', N'O00003465_00000050', N'17390', N'47396', N'17390                                                                                               ', NULL, CAST(N'2020-03-05T00:00:00.000' AS DateTime), CAST(N'2017-02-09T00:00:00.000' AS DateTime), NULL, 2, N'	 222100ZVEE1SLAL6RB69', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 1, N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (30, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Deepview Trading', N'Pharus SICAV - Deepview Trading', N'O00003465_00000051', N'9895', N'40494', N'9895', NULL, NULL, CAST(N'2017-02-09T00:00:00.000' AS DateTime), NULL, 1, N'	 2221005ALDKRRR359415', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 12, 1, 1, N'8 200 PDG33', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (31, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), N'Pharus SICAV - Quintessenza', N'Pharus SICAV  - Quintessenza', N'O00003465_00000028', N'19666', N'40464', N'19666', NULL, NULL, CAST(N'2012-02-02T00:00:00.000' AS DateTime), NULL, 1, N'549300MCDO7CZETH1Y09', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, N'Multiple', NULL, NULL, 2, N'ex Quintessenza ', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (31, CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Dynamic Allocation MV7', N'Pharus SICAV - Dynamic Allocation MV7', N'O00003465_00000028', N'19666', N'40464', N'19666', NULL, NULL, CAST(N'2012-02-02T00:00:00.000' AS DateTime), NULL, 1, N'549300MCDO7CZETH1Y09', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, N'Multiple', NULL, NULL, 2, N'ex Quintessenza ', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (32, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), N'Pharus SICAV - Electric Mobility Niches', N'Pharus SICAV - Electric Mobility Niches', N'	 O00003465_00000055', N'4542', N'44755', N'4542', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 4, N'	 549300YAC68YVVVXQ079', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 1, 3, 1, NULL, NULL, NULL, 2, NULL, N'SUB FUND LAUNCH')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (32, CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Electric Mobility Niches', N'Pharus SICAV - Electric Mobility Niches', N'O00003465_00000055', N'4542', N'44755', N'4542', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 1, N'549300YAC68YVVVXQ079', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 3, 1, NULL, NULL, NULL, 2, NULL, N'SUB FUND LAUNCH')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (33, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Eos', N'Pharus SICAV - Eos', N'O00003465_00000025', N'19661', N'40461', N'19661', NULL, NULL, CAST(N'2011-07-04T00:00:00.000' AS DateTime), NULL, 1, N'549300JBNB0W2FMCVZ95', NULL, 3, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG29', NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (34, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), N'Pharus SICAV - Europe Absolute Return', N'Pharus SICAV - Europe Absolute Return', N'O00003465_00000046', N'9886', N'41784', N'9886', NULL, NULL, CAST(N'2016-05-12T00:00:00.000' AS DateTime), NULL, 1, N'	 222100I3217ZEPUQK436', NULL, 3, 1, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 11, 1, 1, N'Multiple', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (34, CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Europe Total Return', N'Pharus SICAV - Europe Total Return', N'	 O00003465_00000046', N'9886', N'41784', N'9886', NULL, NULL, CAST(N'2016-05-12T00:00:00.000' AS DateTime), NULL, 1, N'	 222100I3217ZEPUQK436', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, N'Multiple', NULL, NULL, 2, N'ex Europe Absolute Return', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (35, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2020-05-25T00:00:00.000' AS DateTime), N'Pharus SICAV - Global Dynamic Opportunities', N'Pharus SICAV - Global Dynamic Opportunities', N'O00003465_00000034', N'19684', N'40483', N'19684', NULL, NULL, CAST(N'2013-01-15T00:00:00.000' AS DateTime), NULL, 1, N'	 549300UK8G6H8OBAFX46', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 12, 1, 3, N'Multiple', NULL, NULL, 7, N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (35, CAST(N'2020-05-26T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Global Dynamic Opportunities', N'Pharus SICAV - Global Dynamic Opportunities', N'O00003465_00000034', N'19684', N'40483', N'19684                                                                                               ', NULL, CAST(N'2020-05-26T00:00:00.000' AS DateTime), CAST(N'2013-01-15T00:00:00.000' AS DateTime), NULL, 2, N'549300UK8G6H8OBAFX46', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, 7, N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (36, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-06T00:00:00.000' AS DateTime), N'Pharus SICAV - Valeur Income', N'Pharus SICAV - Valeur Income', N'O00003465_00000013', N'19640', N'40451', N'19640', NULL, NULL, CAST(N'2009-11-12T00:00:00.000' AS DateTime), NULL, 1, N'549300XAJHZ5S6DKT677', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 3, 3, 1, N'8 200 PDG39', NULL, NULL, 1, N'ex Valeur Income', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (36, CAST(N'2019-02-07T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Global Flexible Bond', N'Pharus SICAV - Global Flexible Bond', N'O00003465_00000013', N'19640', N'40451', N'19640', NULL, NULL, CAST(N'2009-11-12T00:00:00.000' AS DateTime), NULL, 1, N'549300XAJHZ5S6DKT677', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 3, 3, 1, N'8 200 PDG39', NULL, NULL, 1, N'ex Valeur Income', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (37, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Global Value Equity', N'Pharus SICAV - Global Value Equity', N'O00003465_00000041', N'9894', N'40493', N'9894', NULL, NULL, CAST(N'2016-02-10T00:00:00.000' AS DateTime), NULL, 1, N'2221003B2JN3V3ESGR30', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (38, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - I-Bond Plus Solution', N'Pharus SICAV - I-Bond Plus Solution', N'O00003465_00000044', N'9899', N'41782', N'9899', NULL, NULL, CAST(N'2016-05-02T00:00:00.000' AS DateTime), NULL, 1, N'	 222100T975WVXB8ZLF90', NULL, 6, 3, N'USD', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 4, 1, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (39, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - International Equity Quant', N'Pharus SICAV - International Equity Quant', N'O00003465_00000017', N'19655', N'40456', N'19655', NULL, NULL, CAST(N'2009-12-11T00:00:00.000' AS DateTime), NULL, 1, N'	 549300ES0XMCO0CYPL15', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 2, 1, NULL, NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (40, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Liquidity', N'Pharus SICAV - Liquidity', N'O00003465_00000006', N'19673', N'40480', N'19673', NULL, NULL, CAST(N'2002-12-05T00:00:00.000' AS DateTime), NULL, 1, N'	 5493005E4I7C5IQM9V11', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 2, 3, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (41, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Marzotto Active Bond', N'Pharus SICAV - Marzotto Active Bond', N'O00003465_00000042', N'9887', N'41788', N'9887', NULL, NULL, CAST(N'2016-02-10T00:00:00.000' AS DateTime), NULL, 1, N'	 222100TFM3FH5AUIFG89', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, 3, 1, N'8 200 PDG23', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (42, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Marzotto Active Diversified', N'Pharus SICAV - Marzotto Active Diversified', N'O00003465_00000043', N'9897', N'41789', N'9897', NULL, NULL, CAST(N'2016-02-10T00:00:00.000' AS DateTime), NULL, 1, N'222100QX5K8CO406MP08', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, N'8 200 PDG24', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (43, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-06T00:00:00.000' AS DateTime), N'Pharus SICAV - Value', N'Pharus SICAV - Value', N'O00003465_00000011', N'19867', N'41785', N'19867', NULL, NULL, CAST(N'2008-05-20T00:00:00.000' AS DateTime), NULL, 1, N'	 54930004G7UQ6EUX8D07', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 1, 3, 1, N'8 200 PDG36', NULL, NULL, 2, N'ex Value', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (43, CAST(N'2019-02-07T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Next Revolution', N'Pharus SICAV - Next Revolution', N'O00003465_00000011', N'19867', N'41785', N'19867', NULL, NULL, CAST(N'2008-05-20T00:00:00.000' AS DateTime), NULL, 1, N'	 54930004G7UQ6EUX8D07', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG36', NULL, NULL, 2, N'ex Value', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (44, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Southern Europe', N'Pharus SICAV  - Southern Europe', N'O00003465_00000040', N'52294', N'41781', N'52294', NULL, NULL, CAST(N'2015-11-20T00:00:00.000' AS DateTime), NULL, 1, N'	 2221007ABU3XM8HL4G82', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG27', NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (45, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Target', N'Pharus SICAV - Target', N'O00003465_00000026', N'19662', N'40462', N'19662', NULL, NULL, CAST(N'2012-02-02T00:00:00.000' AS DateTime), NULL, 1, N'	 5493005S307UO5UDVQ16', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 4, 3, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (46, CAST(N'2019-11-12T00:00:00.000' AS DateTime), NULL, N'Multi Stars SICAV - Prosperise', N'Multi Stars SICAV - Prosperise', N'O00007588_00000015', N'LU6743', N'5447140', N'LU6743', NULL, NULL, NULL, NULL, 4, N'529900V4I3S8JJ4BJP71', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (47, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Tikehon Global Growth & Income Fund', N'Pharus SICAV - Tikehon Global Growth & Income Fund', N'O00003465_00000037', N'51649', N'40496', N'51649', NULL, NULL, CAST(N'2015-09-01T00:00:00.000' AS DateTime), NULL, 1, N'	 2221008Q176Q8V6EXV22', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 12, 3, 1, N'8 200 PDG31', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (48, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Titan Aggressive', N'Pharus SICAV - Titan Aggressive', N'O00003465_00000016', N'19641', N'40453', N'19641', NULL, NULL, CAST(N'2009-12-11T00:00:00.000' AS DateTime), NULL, 1, N'	 5493009GSR0HWW9CHR28', NULL, 6, 3, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 12, 3, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (49, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Trend Player', N'Pharus SICAV - Trend Player', N'O00003465_00000039', N'51653', N'40498', N'51653', NULL, NULL, CAST(N'2015-09-01T00:00:00.000' AS DateTime), NULL, 1, N'	 222100Y1L0BH7IHTMD28', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, N'8 200 PDG30', NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (50, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Ritom SICAV-RAIF - Peak Fund', N'Ritom SICAV-RAIF - Peak Fund', N'V00001829_00000001', N'48471', N'49011', N'48471', NULL, NULL, CAST(N'2017-08-07T00:00:00.000' AS DateTime), NULL, 1, N'	 549300B5RGUEKZ7L9I50', NULL, NULL, 4, N'EUR', 2, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (50, CAST(N'2019-12-16T00:00:00.000' AS DateTime), NULL, N'Ritom SICAV-RAIF - Peak Fund', N'Ritom SICAV-RAIF - Peak Fund', N'V00001829_00000001', N'48471', N'49011', N'48471                                                                                               ', NULL, CAST(N'2019-12-16T00:00:00.000' AS DateTime), CAST(N'2017-08-07T00:00:00.000' AS DateTime), NULL, 2, N'	 549300B5RGUEKZ7L9I50', NULL, NULL, 4, N'EUR', 2, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, N'Liquidated', N'LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (51, CAST(N'2003-06-20T00:00:00.000' AS DateTime), NULL, N'Sifter Fund - Global', N'Sifter Fund - Global', N'O00003553_00000001', N'038001', N'5126125351', N'038001                                                                                              ', NULL, NULL, CAST(N'2003-06-16T00:00:00.000' AS DateTime), NULL, 2, N'	 549300J13DF5BV0ZMR28', NULL, NULL, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (51, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-08-30T00:00:00.000' AS DateTime), N'Sifter Fund - Global', N'Sifter Fund - Global', N'O00003553_00000001', N'038001', N'5126125351', N'038001', NULL, NULL, CAST(N'2003-06-16T00:00:00.000' AS DateTime), NULL, 1, N'	 549300J13DF5BV0ZMR28', NULL, NULL, NULL, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, N'Changed ManCo to ADEPA', N'CHANGE MANCO')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (52, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV-SIF - Swan Bond Enhanced Fund', N'Swan SICAV-SIF - Swan Bond Enhanced Fund', N'O00007843_00000001', N'19876', N'42081', N'19876', NULL, NULL, CAST(N'2013-05-15T00:00:00.000' AS DateTime), NULL, 1, N'	 549300SVWMINFVPKMY60', NULL, NULL, 1, N'EUR', 1, 9, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (53, CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2019-12-12T00:00:00.000' AS DateTime), N'Swan SICAV-SIF - Swan Dynamic Fund', N'Swan SICAV-SIF - Swan Dynamic Fund', N'O00003465_00000038', N'22187', N'22187', N'22187', NULL, NULL, CAST(N'2014-05-15T00:00:00.000' AS DateTime), NULL, 1, N'	 549300FPV9BDVPIREI41', NULL, NULL, 1, N'EUR', 2, 5, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (53, CAST(N'2019-12-13T00:00:00.000' AS DateTime), NULL, N'Swan SICAV-SIF - Swan Dynamic Fund', N'Swan SICAV-SIF - Swan Dynamic Fund', N'O00003465_00000038', N'22187', N'22187', N'22187                                                                                               ', NULL, NULL, CAST(N'2014-05-15T00:00:00.000' AS DateTime), NULL, 3, N'549300FPV9BDVPIREI41', NULL, NULL, 1, N'EUR', 2, 5, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, N'Closed', N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (54, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV-SIF - Swan Long Short Credit Fund', N'Swan SICAV-SIF - Swan Long Short Credit Fund', N'O00007843_00000003', N'19878', N'42083', N'19878', NULL, NULL, CAST(N'2013-05-15T00:00:00.000' AS DateTime), NULL, 1, N'	 549300XV1ZIXRU3L8895', NULL, NULL, 1, N'EUR', 1, 9, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (55, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL, N'Swan SICAV-SIF - Swan Multistrategy Fund', N'Swan SICAV-SIF - Swan Multistrategy Fund', N'O00007843_00000004', N'19879', N'42084', N'19879', NULL, NULL, CAST(N'2013-05-15T00:00:00.000' AS DateTime), NULL, 1, N'	 549300QR2VGU7UJBGF29', NULL, NULL, 1, N'EUR', 1, 9, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (56, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - BZ  Active Income Fund', N'Timeo Neutral SICAV - BZ  Active Income Fund', N'O00003599_00000015', N'32601', N'32601', N'32601', NULL, NULL, CAST(N'2012-05-23T00:00:00.000' AS DateTime), NULL, 1, N'	 549300YI603JVZXEQD58', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, 3, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (57, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - BZ  Conservative Wolf Fund', N'Timeo Neutral SICAV - BZ  Conservative Wolf Fund', N'O00003599_00000011', N'32537', N'32537', N'32537', NULL, NULL, CAST(N'2012-05-23T00:00:00.000' AS DateTime), NULL, 1, N'	 549300NOX71KNJL64E60', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, 1, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (58, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - BZ  Inflation Linked Bonds Fund', N'Timeo Neutral SICAV - BZ  Inflation Linked Bonds Fund', N'O00003599_00000004', N'32536', N'32536', N'32536', NULL, NULL, CAST(N'2003-09-05T00:00:00.000' AS DateTime), NULL, 1, N'	 549300U86312VBXUYU82', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 2, 3, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (59, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - BZ Syntagma Absolute Return', N'Timeo Neutral SICAV - BZ Syntagma Absolute Return', N'O00003599_00000025', N'49145', N'49145', N'49145', NULL, NULL, CAST(N'2018-06-13T00:00:00.000' AS DateTime), NULL, 1, N'	 529900PNTO7KC889K531', NULL, 6, 1, N'USD', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 3, NULL, NULL, NULL, 7, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (60, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2020-09-14T00:00:00.000' AS DateTime), N'Timeo Neutral SICAV - CFO AMERICA 38', N'Timeo Neutral SICAV - CFO AMERICA 38', N'O00003599_00000021', N'32605', N'32605', N'32605', NULL, NULL, CAST(N'2015-05-18T00:00:00.000' AS DateTime), NULL, 1, N'	 529900WNO21ZCONVZ903', NULL, 4, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, NULL, 7, N'SUBFUND in liquidation', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (60, CAST(N'2020-09-15T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - CFO AMERICA 38', N'Timeo Neutral SICAV - CFO AMERICA 38', N'O00003599_00000021', N'32605', N'32605', N'32605                                                                                               ', NULL, CAST(N'2020-09-15T00:00:00.000' AS DateTime), CAST(N'2015-05-18T00:00:00.000' AS DateTime), NULL, 3, N'	 529900WNO21ZCONVZ903', NULL, 4, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 7, N'SUBFUND in liquidation', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (61, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2020-09-14T00:00:00.000' AS DateTime), N'Timeo Neutral SICAV - CFO EUROPA 38', N'Timeo Neutral SICAV - CFO EUROPA 38', N'O00003599_00000020', N'32604', N'32604', N'32604', NULL, NULL, CAST(N'2015-05-18T00:00:00.000' AS DateTime), NULL, 1, N'	 529900Z85NVXARCBET49', NULL, 3, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, NULL, 7, N'subfund liquidated', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (61, CAST(N'2020-09-15T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - CFO EUROPA 38', N'Timeo Neutral SICAV - CFO EUROPA 38', N'O00003599_00000020', N'32604', N'32604', N'32604                                                                                               ', NULL, CAST(N'2020-09-15T00:00:00.000' AS DateTime), CAST(N'2015-05-18T00:00:00.000' AS DateTime), NULL, 3, N'529900Z85NVXARCBET49', NULL, 3, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 7, N'subfund liquidated', N'SUBFUND IN LIQUIDATION')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (62, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-08-06T00:00:00.000' AS DateTime), N'Timeo Neutral SICAV - European Absolute Return Fund', N'Timeo Neutral SICAV - European Absolute Return Fund', N'O00003599_00000023', N'16400', N'16400', N'16400', NULL, NULL, NULL, NULL, 1, N'	 529900JXF8S6N1I9A690', NULL, 6, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, 8, NULL, N'SUB FUND LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (62, CAST(N'2019-08-07T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - European Absolute Return Fund', N'Timeo Neutral SICAV - European Absolute Return Fund', N'O00003599_00000023', N'16400', N'16400', N'16400                                                                                               ', NULL, NULL, NULL, NULL, 2, N'529900JXF8S6N1I9A690', NULL, 6, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, 8, NULL, N'SUB FUND LIQUIDATED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (63, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, N'United SICAV-RAIF - Market Neutral Actions Euro', N'United SICAV-RAIF - Market Neutral Actions Euro', N'V00001957_00000001', N'1826', N'46581', N'1826', NULL, NULL, CAST(N'2018-04-27T00:00:00.000' AS DateTime), NULL, 1, N'	 54930084108B8S6V7E17', NULL, NULL, 4, N'EUR', 2, 5, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Multiple', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (64, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-04-15T00:00:00.000' AS DateTime), N'1st SICAV - Europe Small Cap', N'1st SICAV - Europe Small Cap', N'	 O00011081_00000004', NULL, NULL, NULL, NULL, NULL, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL, 1, N'222100SQMFTXUFTDP148', NULL, NULL, NULL, N'EUR', 1, 9, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (64, CAST(N'2019-04-16T00:00:00.000' AS DateTime), NULL, N'1st SICAV - Europe Small Cap', N'1st SICAV - Europe Small Cap', N'O00011081_00000004', N'12345', NULL, NULL, NULL, NULL, NULL, NULL, 3, N'222100SQMFTXUFTDP148', NULL, NULL, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, NULL, N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (65, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-06-17T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend', N'Pharus SICAV - Target Equity Dividend', N'	 O00003465_00000057', N'4543', N'44756', N'4543', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 4, N'	 549300G81CVUJTUGB498', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG47', NULL, NULL, 8, NULL, N'SUB FUND LAUNCH')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (65, CAST(N'2019-06-18T00:00:00.000' AS DateTime), CAST(N'2019-12-15T00:00:00.000' AS DateTime), N'Pharus SICAV - Target Equity Dividend', N'Pharus SICAV - Target Equity Dividend', N'	 O00003465_00000057', N'4543', N'44756', N'4543', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 1, N'	 549300G81CVUJTUGB498', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG47', NULL, NULL, 8, N'ex Target Equity Dividend', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (65, CAST(N'2019-12-16T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Best Regulated Companies', N'Pharus SICAV - Best Regulated Companies', N'	 O00003465_00000057', N'4543', N'44756', N'4543', NULL, NULL, CAST(N'2019-01-02T00:00:00.000' AS DateTime), NULL, 1, N'	 549300G81CVUJTUGB498', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 1, 1, 1, N'8 200 PDG47', NULL, NULL, 8, N'ex Target Equity Dividend', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (66, CAST(N'2019-12-18T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Fasanara Quant', N'Pharus SICAV - Fasanara Quant', N'O00003465_00000058', N'402', N'40506', N'402', NULL, NULL, CAST(N'2019-11-08T00:00:00.000' AS DateTime), NULL, 1, N'549300SPDK7HIAE50683', NULL, 6, 1, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (67, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds - Alternative Alpha Strategy
', N'GFG Funds - Alternative Alpha Strategy', N'O00002118_00000019', N'38068', N'38068', N'38068', NULL, NULL, CAST(N'2019-07-22T00:00:00.000' AS DateTime), NULL, 4, N'529900FMU7B2ODIK1F06', NULL, NULL, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (68, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL, N'GFG Funds - Global Corporate Bond', N'GFG Funds - Global Corporate Bond', N'O00002118_00000017', N'38123', N'38123', N'38123', NULL, NULL, CAST(N'2019-07-22T00:00:00.000' AS DateTime), NULL, 1, N'	 5299000ODH2E94NAJ487', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 4, 3, 1, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (69, CAST(N'2019-01-17T00:00:00.000' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), N'Pharus SICAV - Swan Relative Strategy', N'Pharus SICAV - Swan Relative Strategy', NULL, N'51650', N'40497 ', N'51650', NULL, NULL, CAST(N'2014-05-15T00:00:00.000' AS DateTime), NULL, 1, N'	 222100HFMLLX4RV0GU07', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, 2, N'ex Swan Relative Strategy', N'CHANGE OF NAME')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (69, CAST(N'2019-02-15T00:00:00.000' AS DateTime), CAST(N'2019-03-18T00:00:00.000' AS DateTime), N'Pharus SICAV - Swan Dynamic', N'Pharus SICAV - Swan Dynamic', NULL, N'51650', N'40497 ', N'51650', NULL, NULL, CAST(N'2014-05-15T00:00:00.000' AS DateTime), NULL, 1, N'	 222100HFMLLX4RV0GU07', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, 2, NULL, N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (69, CAST(N'2019-03-19T00:00:00.000' AS DateTime), NULL, N'Pharus SICAV - Swan Dynamic', N'Pharus SICAV - Swan Dynamic', NULL, N'51650', N'40497', N'51650', NULL, NULL, CAST(N'2014-05-15T00:00:00.000' AS DateTime), NULL, 3, N'	 222100HFMLLX4RV0GU07', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, 2, NULL, N'SUB FUND CLOSED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (70, CAST(N'2019-08-13T00:00:00.000' AS DateTime), CAST(N'2020-03-04T00:00:00.000' AS DateTime), N'GFG Funds - Global Enhanced Cash', N'GFG Funds - Global Enhanced Cash', N'O00002118_00000018', N'38110', N'38110', N'38110', NULL, NULL, CAST(N'2019-07-22T00:00:00.000' AS DateTime), NULL, 4, N'	 529900BQ5Y6853N43J70', NULL, NULL, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, N'SUB FUND LAUNCHED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (70, CAST(N'2020-03-05T00:00:00.000' AS DateTime), NULL, N'GFG Funds - Global Enhanced Cash', N'GFG Funds - Global Enhanced Cash', N'O00002118_00000018', N'38110', N'38110', N'38110                                                                                               ', NULL, NULL, CAST(N'2019-07-22T00:00:00.000' AS DateTime), NULL, 1, N'529900BQ5Y6853N43J70', NULL, NULL, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, N'SUB FUND LAUNCHED')
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (72, CAST(N'2017-03-01T16:41:00.000' AS DateTime), CAST(N'2019-09-16T00:00:00.000' AS DateTime), N'1st SICAV - Emerging Africa', N'1st SICAV - Emerging Africa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (73, CAST(N'2017-03-01T00:00:00.000' AS DateTime), CAST(N'2019-09-16T00:00:00.000' AS DateTime), N'1st SICAV - Emerging Asia', N'1st SICAV - Emerging Asia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (74, CAST(N'2019-12-01T00:00:00.000' AS DateTime), NULL, N'Ritom SICAV-RAIF - Astipalea', N'Ritom SICAV-RAIF - Astipalea', N'V00001829_00000002', N'23765', N'49014', N'23765', NULL, NULL, CAST(N'2020-01-13T00:00:00.000' AS DateTime), NULL, 1, N'	 5493000JVVGLMY1ZMW60', NULL, NULL, 4, N'EUR', 2, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (75, CAST(N'2019-12-01T00:00:00.000' AS DateTime), NULL, N'Ritom SICAV-RAIF - Archimede', N'Ritom SICAV-RAIF- Archimede', N'V00001829_00000003', N'23764', N'49013', N'23764', NULL, NULL, CAST(N'2020-01-13T00:00:00.000' AS DateTime), NULL, 1, N'	 54930088HSOXBT8ON347', NULL, NULL, 4, N'EUR', 4, 8, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'8-200-PDG57', NULL, NULL, 2, NULL, NULL)
GO
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (76, CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2019-02-25T00:00:00.000' AS DateTime), N'Timeo Neutral SICAV - BZ Equity Value Fund', N'Timeo Neutral SICAV - BZ Equity Value Fund', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, N'	 549300S9JS8VOQX0Y182', NULL, 6, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (77, CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2019-02-25T00:00:00.000' AS DateTime), N'Timeo Neutral SICAV - BZ Diversified Fund', N'Timeo Neutral SICAV - BZ Diversified Fund', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, N'	 5493004EWD82GHG4C578', NULL, 6, NULL, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (78, CAST(N'2019-08-01T00:00:00.000' AS DateTime), NULL, N'Timeo Neutral SICAV - BZ Best Global Managers Flexible Equity', N'Timeo Neutral SICAV - BZ Best Global Managers Flexible Equity', N'	 O00003599_00000024', N'49134', N'49134', N'49134', NULL, NULL, CAST(N'2018-06-13T00:00:00.000' AS DateTime), NULL, 1, N'	 529900POMJB5BDBU5Q05', NULL, 6, 3, N'EUR', 1, 9, 1, 0, NULL, NULL, NULL, NULL, 11, 3, 1, NULL, NULL, NULL, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (79, CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL, N'Bright Stars SICAV-SIF - Stability Fund', N'Bright Stars SICAV-SIF - Stability Fund', N'O00011020_00000002', NULL, NULL, NULL, NULL, NULL, CAST(N'2018-12-18T00:00:00.000' AS DateTime), NULL, 4, NULL, NULL, NULL, NULL, N'EUR', 4, 8, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (84, CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL, N'MH Fund SICAV-SIF - Vitalis Equity-Lux Fund', N'MH Fund SICAV-SIF - Vitalis Equity-Lux Fund', N'O00008878_00000003', N'LU6793', N'LU6793', N'LU6793', CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL, CAST(N'2020-08-28T00:00:00.000' AS DateTime), NULL, 1, N'222100JA8EZLYLRYEN85', 3, 6, 4, N'USD', 1, 9, 1, 1, 3, 3, NULL, NULL, 1, 1, 1, N'LU6793', NULL, 1, 8, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (85, CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL, N'MH Fund SICAV-SIF - Vitalis Fixed Income-Lux Fund', N'MH Fund SICAV-SIF - Vitalis Fixed Income-Lux Fund', N'O00008878_00000004', N'LU6794', N'LU6794', N'LU6794', CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL, CAST(N'2020-08-28T00:00:00.000' AS DateTime), NULL, 1, N'222100345565UTF1H147', 3, 6, 4, N'USD', 1, 9, 1, 1, 3, 3, NULL, NULL, 4, 3, 1, N'LU6794', 256, 2, 1, NULL, NULL)
INSERT [dbo].[tb_historySubFund] ([sf_id], [sf_initialDate], [sf_endDate], [sf_officialSubFundName], [sf_shortSubFundName], [sf_cssfCode], [sf_faCode], [sf_depCode], [sf_taCode], [sf_firstNavDate], [sf_lastNavDate], [sf_cssfAuthDate], [sf_expDate], [sf_status], [sf_leiCode], [sf_cesrClass], [sf_cssf_geographical_focus], [sf_globalExposure], [sf_currency], [sf_navFrequency], [sf_valutationDate], [sf_calculationDate], [sf_derivatives], [sf_derivMarket], [sf_derivPurpose], [sf_lastProspectus], [sf_lastProspectusDate], [sf_principal_asset_class], [sf_type_of_market], [sf_principal_investment_strategy], [sf_clearing_code], [sf_cat_morningstar], [sf_category_six], [sf_category_bloomberg], [sf_change_comment], [sf_comment_title]) VALUES (86, CAST(N'2020-09-04T00:00:00.000' AS DateTime), NULL, N'Emerald Euro Government Bond', N'Emerald Euro Government Bond', N'O00008724_00000003', N'26056', N'26056', N'26056', NULL, NULL, NULL, NULL, 4, NULL, 3, 3, 3, N'EUR', 1, 9, 1, 1, 3, 3, NULL, NULL, 4, 1, 1, NULL, 68, 2, 1, NULL, NULL)
GO
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (1)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (2)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (3)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (4)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (5)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (6)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (7)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (8)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (9)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (10)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (11)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (12)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (13)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (14)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (15)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (16)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (17)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (18)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (19)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (20)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (21)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (22)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (23)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (24)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (25)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (26)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (27)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (28)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (29)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (30)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (31)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (32)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (33)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (34)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (35)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (36)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (37)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (38)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (39)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (40)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (41)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (42)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (43)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (44)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (45)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (46)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (47)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (48)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (49)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (50)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (51)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (52)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (53)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (54)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (55)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (56)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (57)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (58)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (59)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (60)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (61)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (62)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (63)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (64)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (65)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (66)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (67)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (68)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (69)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (70)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (71)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (72)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (73)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (74)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (75)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (76)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (77)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (78)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (79)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (80)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (81)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (82)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (83)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (84)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (85)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (86)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (87)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (88)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (89)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (90)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (91)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (92)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (93)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (94)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (95)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (96)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (97)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (98)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (99)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (100)
GO
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (101)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (102)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (103)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (104)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (105)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (106)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (107)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (108)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (109)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (110)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (111)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (112)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (113)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (114)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (115)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (116)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (117)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (118)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (119)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (120)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (121)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (122)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (123)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (124)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (125)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (126)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (127)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (128)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (129)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (130)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (131)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (132)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (133)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (134)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (135)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (136)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (137)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (138)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (139)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (140)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (141)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (142)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (143)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (144)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (145)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (146)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (147)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (148)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (149)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (150)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (151)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (152)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (153)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (154)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (155)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (156)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (157)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (158)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (159)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (160)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (161)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (162)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (163)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (164)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (165)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (166)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (167)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (168)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (169)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (170)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (171)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (172)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (173)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (174)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (175)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (176)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (177)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (178)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (179)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (180)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (181)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (182)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (183)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (184)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (185)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (186)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (187)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (188)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (189)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (190)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (191)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (192)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (193)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (194)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (195)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (196)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (197)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (198)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (199)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (200)
GO
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (201)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (202)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (203)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (204)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (205)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (206)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (207)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (208)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (209)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (210)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (211)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (212)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (213)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (214)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (215)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (216)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (217)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (218)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (219)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (220)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (221)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (222)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (223)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (224)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (225)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (226)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (227)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (228)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (229)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (230)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (231)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (232)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (233)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (234)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (235)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (236)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (237)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (238)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (239)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (240)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (241)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (242)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (243)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (244)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (245)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (246)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (247)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (248)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (249)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (250)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (251)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (252)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (253)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (254)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (255)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (256)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (257)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (258)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (259)
INSERT [dbo].[tb_shareClass] ([id_sc]) VALUES (260)
GO
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (1)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (2)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (3)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (4)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (5)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (6)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (7)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (8)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (9)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (10)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (11)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (12)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (13)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (14)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (15)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (16)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (17)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (18)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (19)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (20)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (21)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (22)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (23)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (24)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (25)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (26)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (27)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (28)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (29)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (30)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (31)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (32)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (33)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (34)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (35)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (36)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (37)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (38)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (39)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (40)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (41)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (42)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (43)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (44)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (45)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (46)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (47)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (48)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (49)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (50)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (51)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (52)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (53)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (54)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (55)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (56)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (57)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (58)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (59)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (60)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (61)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (62)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (63)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (64)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (65)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (66)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (67)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (68)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (69)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (70)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (71)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (72)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (73)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (74)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (75)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (76)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (77)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (78)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (79)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (80)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (81)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (82)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (83)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (84)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (85)
INSERT [dbo].[tb_subFund] ([id_subFund]) VALUES (86)
GO
ALTER TABLE [dbo].[tb_country_distribution_shares]  WITH CHECK ADD  CONSTRAINT [FK_tb_country_distribution_shares_tb_dom_iso_country] FOREIGN KEY([iso_country_2])
REFERENCES [dbo].[tb_dom_iso_country] ([iso_country_iso_2])
GO
ALTER TABLE [dbo].[tb_country_distribution_shares] CHECK CONSTRAINT [FK_tb_country_distribution_shares_tb_dom_iso_country]
GO
ALTER TABLE [dbo].[tb_country_distribution_shares]  WITH CHECK ADD  CONSTRAINT [FK_tb_country_distribution_shares_tb_dom_languages] FOREIGN KEY([language])
REFERENCES [dbo].[tb_dom_languages] ([language_iso_3])
GO
ALTER TABLE [dbo].[tb_country_distribution_shares] CHECK CONSTRAINT [FK_tb_country_distribution_shares_tb_dom_languages]
GO
ALTER TABLE [dbo].[tb_country_distribution_shares]  WITH CHECK ADD  CONSTRAINT [FK_tb_country_distribution_shares_tb_shareClass] FOREIGN KEY([share_id])
REFERENCES [dbo].[tb_shareClass] ([id_sc])
GO
ALTER TABLE [dbo].[tb_country_distribution_shares] CHECK CONSTRAINT [FK_tb_country_distribution_shares_tb_shareClass]
GO
ALTER TABLE [dbo].[tb_dom_activityType]  WITH CHECK ADD  CONSTRAINT [FK_tb_dom_activityType_tb_dom_entity] FOREIGN KEY([at_entity])
REFERENCES [dbo].[tb_dom_entity] ([entity_id])
GO
ALTER TABLE [dbo].[tb_dom_activityType] CHECK CONSTRAINT [FK_tb_dom_activityType_tb_dom_entity]
GO
ALTER TABLE [dbo].[tb_dom_file_type]  WITH CHECK ADD  CONSTRAINT [FK_tb_dom_file_type_tb_dom_entity] FOREIGN KEY([filetype_entity])
REFERENCES [dbo].[tb_dom_entity] ([entity_id])
GO
ALTER TABLE [dbo].[tb_dom_file_type] CHECK CONSTRAINT [FK_tb_dom_file_type_tb_dom_entity]
GO
ALTER TABLE [dbo].[tb_dom_legal_vehicle]  WITH CHECK ADD  CONSTRAINT [FK_tb_dom_legal_vehicle_tb_dom_legalType] FOREIGN KEY([lv_fk_legal_type])
REFERENCES [dbo].[tb_dom_legal_type] ([lt_id])
GO
ALTER TABLE [dbo].[tb_dom_legal_vehicle] CHECK CONSTRAINT [FK_tb_dom_legal_vehicle_tb_dom_legalType]
GO
ALTER TABLE [dbo].[tb_fundSubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_fundSubFund_tb_fund] FOREIGN KEY([f_id])
REFERENCES [dbo].[tb_fund] ([f_id])
GO
ALTER TABLE [dbo].[tb_fundSubFund] CHECK CONSTRAINT [FK_tb_fundSubFund_tb_fund]
GO
ALTER TABLE [dbo].[tb_fundSubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_fundSubFund_tb_subFund] FOREIGN KEY([sf_id])
REFERENCES [dbo].[tb_subFund] ([id_subFund])
GO
ALTER TABLE [dbo].[tb_fundSubFund] CHECK CONSTRAINT [FK_tb_fundSubFund_tb_subFund]
GO
ALTER TABLE [dbo].[tb_historyContract]  WITH CHECK ADD  CONSTRAINT [FK1_tb_historyContract] FOREIGN KEY([id_contract])
REFERENCES [dbo].[tb_contract] ([id_contract])
GO
ALTER TABLE [dbo].[tb_historyContract] CHECK CONSTRAINT [FK1_tb_historyContract]
GO
ALTER TABLE [dbo].[tb_historyFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyFund_tb_dom_companyType] FOREIGN KEY([f_company_type])
REFERENCES [dbo].[tb_dom_company_type] ([ct_id])
GO
ALTER TABLE [dbo].[tb_historyFund] CHECK CONSTRAINT [FK_tb_historyFund_tb_dom_companyType]
GO
ALTER TABLE [dbo].[tb_historyFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyFund_tb_dom_f_status] FOREIGN KEY([f_status])
REFERENCES [dbo].[tb_dom_f_status] ([st_f_id])
GO
ALTER TABLE [dbo].[tb_historyFund] CHECK CONSTRAINT [FK_tb_historyFund_tb_dom_f_status]
GO
ALTER TABLE [dbo].[tb_historyFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyFund_tb_dom_fund_admin_type] FOREIGN KEY([f_fund_admin])
REFERENCES [dbo].[tb_dom_fund_admin_type] ([fat_id])
GO
ALTER TABLE [dbo].[tb_historyFund] CHECK CONSTRAINT [FK_tb_historyFund_tb_dom_fund_admin_type]
GO
ALTER TABLE [dbo].[tb_historyFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyFund_tb_dom_legal_form] FOREIGN KEY([f_legal_form])
REFERENCES [dbo].[tb_dom_legal_form] ([lf_id])
GO
ALTER TABLE [dbo].[tb_historyFund] CHECK CONSTRAINT [FK_tb_historyFund_tb_dom_legal_form]
GO
ALTER TABLE [dbo].[tb_historyFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyFund_tb_dom_legal_vehicle] FOREIGN KEY([f_legal_vehicle])
REFERENCES [dbo].[tb_dom_legal_vehicle] ([lv_id])
GO
ALTER TABLE [dbo].[tb_historyFund] CHECK CONSTRAINT [FK_tb_historyFund_tb_dom_legal_vehicle]
GO
ALTER TABLE [dbo].[tb_historyFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyFund_tb_fund] FOREIGN KEY([f_id])
REFERENCES [dbo].[tb_fund] ([f_id])
GO
ALTER TABLE [dbo].[tb_historyFund] CHECK CONSTRAINT [FK_tb_historyFund_tb_fund]
GO
ALTER TABLE [dbo].[tb_historyInvAccount]  WITH CHECK ADD  CONSTRAINT [FK1_tb_historyInvAccount] FOREIGN KEY([id_invAccount])
REFERENCES [dbo].[tb_investorAccount] ([id_invAccount])
GO
ALTER TABLE [dbo].[tb_historyInvAccount] CHECK CONSTRAINT [FK1_tb_historyInvAccount]
GO
ALTER TABLE [dbo].[tb_historyInvestor]  WITH CHECK ADD  CONSTRAINT [FK1_tb_historyInvestor] FOREIGN KEY([id_inv])
REFERENCES [dbo].[tb_investor] ([id_inv])
GO
ALTER TABLE [dbo].[tb_historyInvestor] CHECK CONSTRAINT [FK1_tb_historyInvestor]
GO
ALTER TABLE [dbo].[tb_historyShareClass]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyShareClass_tb_dom_investor_type] FOREIGN KEY([sc_investorType])
REFERENCES [dbo].[tb_dom_investor_type] ([it_id])
GO
ALTER TABLE [dbo].[tb_historyShareClass] CHECK CONSTRAINT [FK_tb_historyShareClass_tb_dom_investor_type]
GO
ALTER TABLE [dbo].[tb_historyShareClass]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyShareClass_tb_dom_iso_country] FOREIGN KEY([sc_countryIssue])
REFERENCES [dbo].[tb_dom_iso_country] ([iso_country_iso_2])
GO
ALTER TABLE [dbo].[tb_historyShareClass] CHECK CONSTRAINT [FK_tb_historyShareClass_tb_dom_iso_country]
GO
ALTER TABLE [dbo].[tb_historyShareClass]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyShareClass_tb_dom_share_status] FOREIGN KEY([sc_status])
REFERENCES [dbo].[tb_dom_share_status] ([sc_s_id])
GO
ALTER TABLE [dbo].[tb_historyShareClass] CHECK CONSTRAINT [FK_tb_historyShareClass_tb_dom_share_status]
GO
ALTER TABLE [dbo].[tb_historyShareClass]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyShareClass_tb_dom_share_type] FOREIGN KEY([sc_shareType])
REFERENCES [dbo].[tb_dom_share_type] ([st_id])
GO
ALTER TABLE [dbo].[tb_historyShareClass] CHECK CONSTRAINT [FK_tb_historyShareClass_tb_dom_share_type]
GO
ALTER TABLE [dbo].[tb_historyShareClass]  WITH CHECK ADD  CONSTRAINT [FK_tb_historyShareClass_tb_shareClass] FOREIGN KEY([sc_id])
REFERENCES [dbo].[tb_shareClass] ([id_sc])
GO
ALTER TABLE [dbo].[tb_historyShareClass] CHECK CONSTRAINT [FK_tb_historyShareClass_tb_shareClass]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_calculationDate] FOREIGN KEY([sf_calculationDate])
REFERENCES [dbo].[tb_dom_calculationDate] ([cd_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_calculationDate]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_cesrClass] FOREIGN KEY([sf_cesrClass])
REFERENCES [dbo].[tb_dom_cesrClass] ([cc_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_cesrClass]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_cssf_geographical_focus] FOREIGN KEY([sf_cssf_geographical_focus])
REFERENCES [dbo].[tb_dom_cssf_geographical_focus] ([gf_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_cssf_geographical_focus]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_cssf_principal_asset_class] FOREIGN KEY([sf_principal_asset_class])
REFERENCES [dbo].[tb_dom_cssf_principal_asset_class] ([pac_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_cssf_principal_asset_class]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_derivMarket] FOREIGN KEY([sf_derivMarket])
REFERENCES [dbo].[tb_dom_derivMarket] ([dm_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_derivMarket]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_derivPurpose] FOREIGN KEY([sf_derivPurpose])
REFERENCES [dbo].[tb_dom_derivPurpose] ([dp_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_derivPurpose]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_globalExposure] FOREIGN KEY([sf_globalExposure])
REFERENCES [dbo].[tb_dom_globalExposure] ([ge_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_globalExposure]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_navFrequency] FOREIGN KEY([sf_navFrequency])
REFERENCES [dbo].[tb_dom_navFrequency] ([nf_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_navFrequency]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_principal_investment_strategy] FOREIGN KEY([sf_principal_investment_strategy])
REFERENCES [dbo].[tb_dom_principal_investment_strategy] ([pis_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_principal_investment_strategy]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_type_of_market] FOREIGN KEY([sf_type_of_market])
REFERENCES [dbo].[tb_dom_type_of_market] ([tom_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_type_of_market]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_dom_valutationDate] FOREIGN KEY([sf_valutationDate])
REFERENCES [dbo].[tb_dom_valutationDate] ([vd_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_dom_valutationDate]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_subFund] FOREIGN KEY([sf_status])
REFERENCES [dbo].[tb_dom_sf_status] ([st_id])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_subFund]
GO
ALTER TABLE [dbo].[tb_historySubFund]  WITH CHECK ADD  CONSTRAINT [FK_tb_historySubFund_tb_subFund1] FOREIGN KEY([sf_id])
REFERENCES [dbo].[tb_subFund] ([id_subFund])
GO
ALTER TABLE [dbo].[tb_historySubFund] CHECK CONSTRAINT [FK_tb_historySubFund_tb_subFund1]
GO
ALTER TABLE [dbo].[tb_invInvAccount]  WITH CHECK ADD  CONSTRAINT [FK1_tb_invInvAccount] FOREIGN KEY([id_inv])
REFERENCES [dbo].[tb_investor] ([id_inv])
GO
ALTER TABLE [dbo].[tb_invInvAccount] CHECK CONSTRAINT [FK1_tb_invInvAccount]
GO
ALTER TABLE [dbo].[tb_invInvAccount]  WITH CHECK ADD  CONSTRAINT [FK2_tb_invInvAccount] FOREIGN KEY([id_invAccount])
REFERENCES [dbo].[tb_investorAccount] ([id_invAccount])
GO
ALTER TABLE [dbo].[tb_invInvAccount] CHECK CONSTRAINT [FK2_tb_invInvAccount]
GO
ALTER TABLE [dbo].[tb_invInvAccShareClass]  WITH CHECK ADD  CONSTRAINT [FK1_tb_invInvAccShareClass] FOREIGN KEY([id_inv])
REFERENCES [dbo].[tb_investor] ([id_inv])
GO
ALTER TABLE [dbo].[tb_invInvAccShareClass] CHECK CONSTRAINT [FK1_tb_invInvAccShareClass]
GO
ALTER TABLE [dbo].[tb_invInvAccShareClass]  WITH CHECK ADD  CONSTRAINT [FK2_invInvAccShareClass] FOREIGN KEY([id_invAccount])
REFERENCES [dbo].[tb_investorAccount] ([id_invAccount])
GO
ALTER TABLE [dbo].[tb_invInvAccShareClass] CHECK CONSTRAINT [FK2_invInvAccShareClass]
GO
ALTER TABLE [dbo].[tb_invInvAccShareClass]  WITH CHECK ADD  CONSTRAINT [FK3_invInvAccShareClass] FOREIGN KEY([id_shareClass])
REFERENCES [dbo].[tb_shareClass] ([id_sc])
GO
ALTER TABLE [dbo].[tb_invInvAccShareClass] CHECK CONSTRAINT [FK3_invInvAccShareClass]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_timeseries_shareclass](
	[date_ts] [datetime] NOT NULL,
	[id_ts] [int] NOT NULL,
	[value_ts] [decimal](18, 9) NULL,
	[currency_ts] [nchar](3) NOT NULL,
	[provider_ts] [int] NOT NULL,
	[id_shareclass] [int] NOT NULL,
 CONSTRAINT [PK_tb_timeseries_shareclass] PRIMARY KEY CLUSTERED 
(
	[date_ts] ASC,
	[id_ts] ASC,
	[currency_ts] ASC,
	[provider_ts] ASC,
	[id_shareclass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_timeseries_subfund](
	[date_ts] [datetime] NOT NULL,
	[id_ts] [int] NOT NULL,
	[value_ts] [decimal](18, 9) NULL,
	[currency_ts] [nchar](3) NOT NULL,
	[provider_ts] [int] NOT NULL,
	[id_subfund] [int] NOT NULL,
 CONSTRAINT [PK_tb_timeseries_subfund] PRIMARY KEY CLUSTERED 
(
	[date_ts] ASC,
	[id_ts] ASC,
	[currency_ts] ASC,
	[provider_ts] ASC,
	[id_subfund] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAuM_fund_test]

@datereport as date

AS
BEGIN

DECLARE @dt nvarchar(max), @dtr nvarchar(max)
	
select @dt = STUFF((select top 8'],[' + yearmonth  
					from (select yearmonth, datetoorder, ROW_NUMBER ( ) OVER (partition by datetoorder order by datetoorder) idordered  from (
							select 
							convert(varchar(10),CAST(Datename(month, date_ts) AS VARCHAR(3))+ '-' + CAST(YEAR(date_ts) AS VARCHAR(4)),112) yearmonth, 
							DATEFROMPARTS([Year], [Month], 01) datetoorder from (
							select distinct top 500 date_ts, convert(varchar(10),CAST(Datename(month, date_ts) AS VARCHAR(3))+ '-' + CAST(YEAR(date_ts) AS VARCHAR(4)),112) yearmonth, MONTH(date_ts) [Month], year(date_ts) [Year]
							from tb_timeseries_subfund tssf where tssf.id_ts=10 and @datereport >= date_ts
							)tb2
							)tb3
					)dtr where idordered=1  order by datetoorder desc
					for xml path('')),1,2,'')+ ']'
set @dtr= 'declare @report_date as date=''' + convert(varchar(10), @datereport,112) +
	'''; 
SELECT 	[ID],[NAME], ' + @dt + ' 	from( 
		SELECT 
		f.f_id [ID],
		f.f_official_fund_name [NAME],
		sum(tssf.value_ts) TOTAUMEUR,
		CAST(Datename(month, tssf.date_ts) AS VARCHAR(3))+ ''-'' + CAST(YEAR(tssf.date_ts) AS VARCHAR(4)) as MONTH_YEAR
		FROM tb_historyFund f
		JOIN ( 
					SELECT fsf.sf_id, fsf.fsf_startConnection, fsf.fsf_endConnection, fsf.f_id 
					FROM [dbo].tb_fundSubFund fsf 
					Where 
						(@report_date between fsf.fsf_startConnection and fsf.fsf_endConnection OR (@report_date >= fsf.fsf_startConnection and fsf.fsf_endConnection is null)) 
				 ) t2  ON f.f_id = t2.f_id 

		Join tb_timeseries_subfund tssf on tssf.id_subfund=t2.sf_id 
		where (@report_date between f.f_initial_date and f.f_end_date  OR (@report_date >= f.f_initial_date and f.f_end_date is null)) 
		group by f.f_id ,
		f.f_official_fund_name,
		CAST(Datename(month, tssf.date_ts) AS VARCHAR(3))+ ''-'' + CAST(YEAR(tssf.date_ts) AS VARCHAR(4))

)as tb2
pivot
(
  max(TOTAUMEUR)
  for MONTH_YEAR in ('+  @dt + ')) as piv;'
  execute sp_executesql @dtr
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_AuM_subfund_EOM]
(	
		@report_date date 
)
RETURNS TABLE 
AS
RETURN 
(

Select 
f_sf.f_official_fund_name [Fund Name]
,f_sf.sf_faCode [Fund Admin SF Code]
,f_sf.sf_officialSubFundName [SubFund Name]
,f_sf.sf_currency [CCY]
,f_Sf.nf_desc [NAV Frequency]
,convert(varchar, tssf.date_ts, 103)[EOM NAV date]
,CONVERT(DECIMAL(15,2),tssf.value_ts) [AuM in EUR]
,f_sf.f_id[Fund Id]
,f_sf.sf_id[SubFund Id]
from (
	SELECT f_official_fund_name, sf_currency, t3.sf_id, t3.sf_faCode, sf_officialSubFundName, t3.nf_desc, t2.f_id
	FROM (
	SELECT f.f_id, f.f_official_fund_name
		FROM [dbo].tb_historyFund f 
		Where (@report_date between f.f_initial_date and f.f_end_date OR (@report_date >= f.f_initial_date and f.f_end_date is null)) ) t1 
		JOIN ( 
				SELECT fsf.sf_id, fsf.fsf_startConnection, fsf.fsf_endConnection, fsf.f_id 
				FROM [dbo].tb_fundSubFund fsf 
				Where 
					(@report_date between fsf.fsf_startConnection and fsf.fsf_endConnection OR (@report_date >= fsf.fsf_startConnection and fsf.fsf_endConnection is null)) 
			 ) t2  ON t1.f_id = t2.f_id 
		JOIN ( 
		SELECT  sf.sf_officialSubFundName, sf.sf_id,sf.sf_currency,sf.sf_faCode, nf.nf_desc FROM [dbo].tb_historySubFund sf 	
		join tb_dom_navFrequency nf on nf.nf_id=sf.sf_navFrequency
		Where (@report_date between sf.sf_initialDate and sf.sf_endDate OR (@report_date >= sf.sf_initialDate and sf.sf_endDate is null)) 
			 ) t3 ON t2.sf_id = t3.sf_id
	)f_sf 
	join tb_timeseries_subfund tssf
	on f_sf.sf_id=tssf.id_subfund and id_ts=10 and (tssf.date_ts between DATEADD(DAY, 1, EOMONTH(@report_date, -1)) and EOMONTH(@report_date))
)
GO
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (1, 7, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (2, 7, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (3, 7, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (4, 6, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (5, 5, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (6, 5, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (7, 4, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (8, 4, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (9, 3, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (10, 3, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (11, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (12, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (13, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (14, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (15, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (16, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (17, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (18, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (19, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (20, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (21, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (22, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (23, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (24, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (25, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (26, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (27, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (28, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (29, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (30, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (31, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (32, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (33, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (34, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (35, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (36, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (37, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (38, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (39, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (40, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (41, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (42, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (43, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (44, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (45, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (46, 2, CAST(N'2019-11-12T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (47, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (48, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (49, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (50, 8, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (51, 16, CAST(N'2003-06-20T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (52, 10, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (53, 10, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (54, 10, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (55, 10, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (56, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (57, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (58, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (59, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (60, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (61, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (62, 11, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (63, 12, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (64, 7, CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (65, 1, CAST(N'2019-02-15T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (66, 1, CAST(N'2019-12-18T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (67, 5, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (68, 5, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (69, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (70, 5, CAST(N'2019-08-13T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (71, 1, CAST(N'2019-01-17T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (72, 7, CAST(N'2017-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (73, 7, CAST(N'2017-03-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (74, 8, CAST(N'2019-12-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (75, 8, CAST(N'2019-12-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (76, 11, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (77, 11, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (78, 11, CAST(N'2018-08-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (79, 6, CAST(N'2017-06-30T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (81, 1, CAST(N'2020-06-18T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (83, 1, CAST(N'2020-09-30T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (84, 15, CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (85, 15, CAST(N'2020-08-31T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[tb_fundSubFund] ([sf_id], [f_id], [fsf_startConnection], [fsf_endConnection]) VALUES (86, 4, CAST(N'2020-09-04T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-26T00:00:00.000' AS DateTime), 10, CAST(60243571.808083600 AS Decimal(18, 9)), N'EUR', 5, 18)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(5523425.750000000 AS Decimal(18, 9)), N'EUR', 1, 1)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(19124328.820000000 AS Decimal(18, 9)), N'EUR', 1, 2)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(5936216.210000000 AS Decimal(18, 9)), N'EUR', 1, 3)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(22649756.580000000 AS Decimal(18, 9)), N'EUR', 1, 9)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(50420631.950000000 AS Decimal(18, 9)), N'EUR', 1, 10)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(52535957.250000000 AS Decimal(18, 9)), N'EUR', 1, 21)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(44840526.080000000 AS Decimal(18, 9)), N'EUR', 1, 22)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(16799837.800000000 AS Decimal(18, 9)), N'EUR', 1, 23)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(18619393.900000000 AS Decimal(18, 9)), N'EUR', 1, 24)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(14419202.170000000 AS Decimal(18, 9)), N'EUR', 1, 25)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(17458140.080000000 AS Decimal(18, 9)), N'EUR', 1, 27)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(16883904.370000000 AS Decimal(18, 9)), N'EUR', 1, 28)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(15658475.930000000 AS Decimal(18, 9)), N'EUR', 1, 30)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(18877205.450000000 AS Decimal(18, 9)), N'EUR', 1, 31)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(11116478.050000000 AS Decimal(18, 9)), N'EUR', 1, 32)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(10120696.360000000 AS Decimal(18, 9)), N'EUR', 1, 33)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(99822115.910000000 AS Decimal(18, 9)), N'EUR', 1, 34)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(58144216.970000000 AS Decimal(18, 9)), N'EUR', 1, 36)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(51016510.560000000 AS Decimal(18, 9)), N'EUR', 1, 37)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(37987665.647180400 AS Decimal(18, 9)), N'EUR', 1, 38)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(15551907.870000000 AS Decimal(18, 9)), N'EUR', 1, 39)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(17250158.240000000 AS Decimal(18, 9)), N'EUR', 1, 40)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(6580658.740000000 AS Decimal(18, 9)), N'EUR', 1, 41)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(7854626.770000000 AS Decimal(18, 9)), N'EUR', 1, 42)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(15932688.340000000 AS Decimal(18, 9)), N'EUR', 1, 43)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(23418850.920000000 AS Decimal(18, 9)), N'EUR', 1, 44)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(67220409.050000000 AS Decimal(18, 9)), N'EUR', 1, 45)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(33835054.620000000 AS Decimal(18, 9)), N'EUR', 1, 47)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(9392616.760000000 AS Decimal(18, 9)), N'EUR', 1, 48)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(27019552.960000000 AS Decimal(18, 9)), N'EUR', 1, 49)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(126341853.940000000 AS Decimal(18, 9)), N'EUR', 1, 52)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(48452522.720000000 AS Decimal(18, 9)), N'EUR', 1, 54)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(4530764.440000000 AS Decimal(18, 9)), N'EUR', 1, 55)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(1742601.160000000 AS Decimal(18, 9)), N'EUR', 1, 63)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(59555350.150000000 AS Decimal(18, 9)), N'EUR', 1, 65)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(13699890.850000000 AS Decimal(18, 9)), N'EUR', 1, 66)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(9459237.770000000 AS Decimal(18, 9)), N'EUR', 1, 74)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(1955663.530000000 AS Decimal(18, 9)), N'EUR', 1, 75)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(268326730.970000000 AS Decimal(18, 9)), N'EUR', 2, 5)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(39340048.820000000 AS Decimal(18, 9)), N'EUR', 2, 6)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(25253382.920000000 AS Decimal(18, 9)), N'EUR', 2, 7)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(32377845.100000000 AS Decimal(18, 9)), N'EUR', 2, 8)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(34866392.840000000 AS Decimal(18, 9)), N'EUR', 2, 56)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(17196668.130000000 AS Decimal(18, 9)), N'EUR', 2, 57)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(6656930.140000000 AS Decimal(18, 9)), N'EUR', 2, 58)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(23783878.472078100 AS Decimal(18, 9)), N'EUR', 2, 59)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(8920281.860000000 AS Decimal(18, 9)), N'EUR', 2, 68)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(8337245.540000000 AS Decimal(18, 9)), N'EUR', 2, 70)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(14345010.580000000 AS Decimal(18, 9)), N'EUR', 2, 78)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(44591190.682544000 AS Decimal(18, 9)), N'EUR', 5, 4)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(10355671.350000000 AS Decimal(18, 9)), N'EUR', 5, 11)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(17828068.610000000 AS Decimal(18, 9)), N'EUR', 5, 12)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(5872385.960000000 AS Decimal(18, 9)), N'EUR', 5, 14)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(31334299.330000000 AS Decimal(18, 9)), N'EUR', 5, 15)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(27553268.710000000 AS Decimal(18, 9)), N'EUR', 5, 16)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(146802343.960000000 AS Decimal(18, 9)), N'EUR', 5, 17)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(82689718.264729100 AS Decimal(18, 9)), N'EUR', 5, 19)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(14128496.230000000 AS Decimal(18, 9)), N'EUR', 5, 20)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(30760289.803608100 AS Decimal(18, 9)), N'EUR', 5, 84)
INSERT [dbo].[tb_timeseries_subfund] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_subfund]) VALUES (CAST(N'2020-11-30T00:00:00.000' AS DateTime), 10, CAST(27832058.738324000 AS Decimal(18, 9)), N'EUR', 5, 85)
GO
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(100.930000000 AS Decimal(18, 9)), N'EUR', 1, 81)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(95.780000000 AS Decimal(18, 9)), N'EUR', 1, 82)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(98.410000000 AS Decimal(18, 9)), N'EUR', 1, 83)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(104.390000000 AS Decimal(18, 9)), N'EUR', 1, 84)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(96.740000000 AS Decimal(18, 9)), N'EUR', 1, 100)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(105.730000000 AS Decimal(18, 9)), N'EUR', 1, 101)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(102.120000000 AS Decimal(18, 9)), N'EUR', 1, 102)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(148.630000000 AS Decimal(18, 9)), N'EUR', 1, 128)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(156.230000000 AS Decimal(18, 9)), N'EUR', 1, 129)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(107.120000000 AS Decimal(18, 9)), N'EUR', 1, 130)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(128.930000000 AS Decimal(18, 9)), N'EUR', 1, 131)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(102.650000000 AS Decimal(18, 9)), N'EUR', 1, 134)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(100.900000000 AS Decimal(18, 9)), N'EUR', 1, 135)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(10222.370000000 AS Decimal(18, 9)), N'EUR', 1, 136)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(102.220000000 AS Decimal(18, 9)), N'EUR', 1, 137)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(110.270000000 AS Decimal(18, 9)), N'EUR', 1, 157)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(107.990000000 AS Decimal(18, 9)), N'EUR', 1, 158)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(109.290000000 AS Decimal(18, 9)), N'EUR', 1, 159)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(118.530000000 AS Decimal(18, 9)), N'EUR', 1, 160)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(131.100000000 AS Decimal(18, 9)), N'EUR', 1, 161)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(132.740000000 AS Decimal(18, 9)), N'EUR', 1, 162)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(134.530000000 AS Decimal(18, 9)), N'EUR', 1, 163)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(113.010000000 AS Decimal(18, 9)), N'USD', 1, 71)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(102.620000000 AS Decimal(18, 9)), N'USD', 1, 87)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(104.290000000 AS Decimal(18, 9)), N'USD', 1, 126)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(106.630000000 AS Decimal(18, 9)), N'USD', 1, 127)
INSERT [dbo].[tb_timeseries_shareclass] ([date_ts], [id_ts], [value_ts], [currency_ts], [provider_ts], [id_shareclass]) VALUES (CAST(N'2020-01-14T00:00:00.000' AS DateTime), 5, CAST(111.850000000 AS Decimal(18, 9)), N'USD', 1, 132)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_active_shareclass]
(	
		@report_date date 
)
RETURNS TABLE 
AS
RETURN 
(

SELECT TOP(1000) 

 [ID]	
,[VALID FROM]
,case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL]
,[NAME]
,[STATUS]
,[ISIN]
,[INVESTOR TYPE]
,[SHARE TYPE]
,[CCY]
,[COUNTRY ISSUE]
,[ULT PARENT COUNTRY OF RISK]
,[EMISSION DATE]
,[INCEPTION DATE]
,[LAST NAV]
,[EXPIRY DATE]
,[INITIAL PRICE]
,[ACCOUNTING CODE]
,[HEDGED]
,[LISTED]
,[BLOOMBERG MARKET]
,[BLOOMBERG CODE]
,[BLOOMBERG ID]
,[VALOR CODE]
,[FUND ADMIN. CODE]
,[TRASFER AGENT CODE]
,[WKN CODE]
,[BUSINESS YEAR]
,[PROSPECTUS CODE]	
FROM 
( 

SELECT

 sc_id [ID]	
,convert(varchar, sc_initialDate, 103) [VALID FROM]
,convert(varchar, sc_endDate, 103) [VALID UNTIL]
,sc_officialShareClassName [NAME]
,stat.sc_s_desc [STATUS]
,intype.it_desc [INVESTOR TYPE]
,sharetype.st_desc [SHARE TYPE]
,sc_currency [CCY]
,sc_countryIssue [COUNTRY ISSUE]
,sc_ultimateParentCountryRisk [ULT PARENT COUNTRY OF RISK]
,convert(varchar, sc_emissionDate, 103) [EMISSION DATE]
,convert(varchar, sc_inceptionDate, 103) [INCEPTION DATE]
,convert(varchar, sc_lastNav, 103) [LAST NAV]
,convert(varchar, sc_expiryDate, 103) [EXPIRY DATE]
,sc_initialPrice [INITIAL PRICE]
,sc_accountingCode [ACCOUNTING CODE]
,case 
	when sc_hedged=1 then 'Yes'
	when sc_hedged=0 then 'No'
	else NULL
	END as [HEDGED]
,case 
	when sc_listed=1 then 'Yes'
	when sc_listed=0 then 'No'
	else NULL
	END as  [LISTED]
,sc_bloomberMarket [BLOOMBERG MARKET]
,sc_bloombedCode [BLOOMBERG CODE]
,sc_bloombedId [BLOOMBERG ID]
,sc_isinCode [ISIN]
,sc_valorCode [VALOR CODE]
,sc_faCode [FUND ADMIN. CODE]
,sc_taCode [TRASFER AGENT CODE]
,sc_WKN [WKN CODE]
,convert(varchar, sc_date_business_year, 103)  [BUSINESS YEAR]
,sc_prospectus_code [PROSPECTUS CODE]	
	
	FROM tb_historyShareClass sc
	left join tb_dom_investor_type intype on intype.it_id=sc.sc_investorType
	left join tb_dom_share_type sharetype on sharetype.st_id= sc.sc_shareType
	left join tb_dom_share_status stat on stat.sc_s_id=sc.sc_status
		
	Where (
		@report_date between sc.sc_initialDate and sc.sc_endDate  OR (@report_date > sc.sc_initialDate and sc.sc_endDate is null)
			 and stat.sc_s_desc = 'Active'		 
	)
) t2
 ORDER BY t2.[NAME]
)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_active_fund_active_subfunds]
(	
 @report_date as date,
 @fund_id as int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT top(100)
 [ID]
,[VALID FROM]
, case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL]
, [SUB FUND NAME]
, [STATUS]
, [CSSF CODE]
, [ADMIN CODE]
, [DEPOSITARY BANK CODE]
, [TRANSFER AGENT CODE]
, [FIRST NAV DATE]
, [LAST NAV DATE]
, [CSSF AUTH. DATE]
, [EXPIRY DATE]
,[LEI CODE]
,[CESR CLASS]
,[GEO FOCUS]
,[GLOBAL EXPOSURE]
,[CURRENCY]
,[FREQUENCY]
,[VALUATION DATE]
,[CALCULATION DATE]
,[DERIVATIVES]
,[DERIV. MARKET]
,[DERIV. PURPOSE]
,[PRINCIPAL ASSET CLASS]
,[MARKET TYPE]
,[PRINCIPAL INVESTMENT STRATEGY]
,[CLEARING CODE]
,[MORNINGSTAR CATEGORY]
,[SIX CATEGORY]
,[BLOOMBERG CATEGORY]	
FROM ( 
	SELECT f.f_id, f.f_official_fund_name
	FROM [dbo].tb_historyFund f 
	Where (@report_date between f.f_initial_date and f.f_end_date OR (@report_date >= f.f_initial_date and f.f_end_date is null)) ) t1 
	JOIN ( 
			SELECT fsf.sf_id, fsf.fsf_startConnection, fsf.fsf_endConnection, fsf.f_id 
			FROM [dbo].tb_fundSubFund fsf 
			Where 
				(@report_date between fsf.fsf_startConnection and fsf.fsf_endConnection OR (@report_date >= fsf.fsf_startConnection and fsf.fsf_endConnection is null)) 
		 ) t2  ON t1.f_id = t2.f_id and t1.f_id=@fund_id
	
	JOIN ( 
			SELECT  
 sf_id [ID]
 ,convert(varchar,sf_initialDate,103) [VALID FROM]
,convert(varchar,sf_endDate,103) [VALID UNTIL]
,sf_officialSubFundName [SUB FUND NAME]
,sfstat.st_desc [STATUS]
,sf_cssfCode [CSSF CODE]
,sf_faCode [ADMIN CODE]
,sf_depCode [DEPOSITARY BANK CODE]
,sf_taCode [TRANSFER AGENT CODE]
,sf_firstNavDate [FIRST NAV DATE]
,sf_lastNavDate [LAST NAV DATE]
,sf_cssfAuthDate [CSSF AUTH. DATE]
,sf_expDate  [EXPIRY DATE]
,sf_leiCode [LEI CODE]
,sfcesr.c_desc [CESR CLASS]
,sfgeo.gf_desc [GEO FOCUS]
,sfge.ge_desc [GLOBAL EXPOSURE]
,sf_currency [CURRENCY]
,nfreq.nf_desc [FREQUENCY]
,vdate.vd_desc [VALUATION DATE]
,cdate.cd_desc [CALCULATION DATE]
,case 
	when sf_derivatives=1 then 'YES'
	when sf_derivatives=0 then 'NO'
	else NULL
	END as [DERIVATIVES]
,dmar.dm_desc [DERIV. MARKET]
,dpur.dp_desc [DERIV. PURPOSE]
,sf_lastProspectus [LAST PROSPECTUS]
,sf_lastProspectusDate [LAST PROSPECTUS DATE]
,pac.pac_desc [PRINCIPAL ASSET CLASS]
,tom.tom_desc [MARKET TYPE]
,pis.pis_desc [PRINCIPAL INVESTMENT STRATEGY]
,sf_clearing_code [CLEARING CODE]
,cms.c_morningstar_desc [MORNINGSTAR CATEGORY]
,cs.cat_six_desc [SIX CATEGORY]
,cb.cat_bloomberg_Desc [BLOOMBERG CATEGORY]	

			FROM [dbo].tb_historySubFund sf
				left join tb_dom_sf_status sfstat on sfstat.st_id=sf.sf_status
				left join tb_dom_cesrClass sfcesr on sfcesr.cc_id=sf.sf_cesrClass
				left join tb_dom_cssf_geographical_focus sfgeo on sfgeo.gf_id=sf.sf_cssf_geographical_focus
				left join tb_dom_globalExposure sfge on sfge.ge_id=sf.sf_globalExposure
				left join tb_dom_navFrequency nfreq on nfreq.nf_id=sf.sf_navFrequency
				left join tb_dom_valutationDate vdate on vdate.vd_id=sf.sf_valutationDate
				left join tb_dom_calculationDate cdate on cdate.cd_id=sf.sf_calculationDate
				left join tb_dom_derivMarket dmar on dmar.dm_id=sf.sf_derivMarket
				left join tb_dom_derivPurpose dpur on dpur.dp_id=sf.sf_derivPurpose
				left join tb_dom_cssf_principal_asset_class pac on pac.pac_id=sf.sf_principal_asset_class
				left join tb_dom_type_of_market tom on tom.tom_id=sf.sf_type_of_market
				left join tb_dom_principal_investment_strategy pis on pis.pis_id=sf.sf_principal_investment_strategy
				left join tb_dom_sf_cat_morningstar cms on cms.c_morningstar_id=sf.sf_cat_morningstar
				left join tb_dom_sf_cat_six cs on cs.cat_six_id=sf.sf_category_six
				left join tb_dom_sf_cat_bloomberg cb on cb.cat_bloomberg_id=sf.sf_category_bloomberg
			Where (@report_date between sf.sf_initialDate and sf.sf_endDate OR (@report_date >= sf.sf_initialDate and sf.sf_endDate is null) and sfstat.st_desc = 'Active') 
		 ) t3 ON t2.sf_id = t3.[ID] 
                 ORDER BY t3.[SUB FUND NAME]
)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_active_fund_subfunds]
(	
 @report_date as date,
 @fund_id as int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT top(100)
 [ID]
,[VALID FROM]
, case
	when [VALID UNTIL] is null then 'STILL VALID'
	else [VALID UNTIL] end as [VALID UNTIL]
, [SUB FUND NAME]
, [STATUS]
, [CSSF CODE]
, [ADMIN CODE]
, [DEPOSITARY BANK CODE]
, [TRANSFER AGENT CODE]
, [FIRST NAV DATE]
, [LAST NAV DATE]
, [CSSF AUTH. DATE]
, [EXPIRY DATE]
,[LEI CODE]
,[CESR CLASS]
,[GEO FOCUS]
,[GLOBAL EXPOSURE]
,[CURRENCY]
,[FREQUENCY]
,[VALUATION DATE]
,[CALCULATION DATE]
,[DERIVATIVES]
,[DERIV. MARKET]
,[DERIV. PURPOSE]
,[PRINCIPAL ASSET CLASS]
,[MARKET TYPE]
,[PRINCIPAL INVESTMENT STRATEGY]
,[CLEARING CODE]
,[MORNINGSTAR CATEGORY]
,[SIX CATEGORY]
,[BLOOMBERG CATEGORY]	
FROM ( 
	SELECT f.f_id, f.f_official_fund_name
	FROM [dbo].tb_historyFund f 
	Where (@report_date between f.f_initial_date and f.f_end_date OR (@report_date >= f.f_initial_date and f.f_end_date is null)) ) t1 
	JOIN ( 
			SELECT fsf.sf_id, fsf.fsf_startConnection, fsf.fsf_endConnection, fsf.f_id 
			FROM [dbo].tb_fundSubFund fsf 
			Where 
				(@report_date between fsf.fsf_startConnection and fsf.fsf_endConnection OR (@report_date >= fsf.fsf_startConnection and fsf.fsf_endConnection is null)) 
		 ) t2  ON t1.f_id = t2.f_id and t1.f_id=@fund_id
	
	JOIN ( 
			SELECT  
 sf_id [ID]
 ,convert(varchar,sf_initialDate,103) [VALID FROM]
,convert(varchar,sf_endDate,103) [VALID UNTIL]
,sf_officialSubFundName [SUB FUND NAME]
,sfstat.st_desc [STATUS]
,sf_cssfCode [CSSF CODE]
,sf_faCode [ADMIN CODE]
,sf_depCode [DEPOSITARY BANK CODE]
,sf_taCode [TRANSFER AGENT CODE]
,sf_firstNavDate [FIRST NAV DATE]
,sf_lastNavDate [LAST NAV DATE]
,sf_cssfAuthDate [CSSF AUTH. DATE]
,sf_expDate  [EXPIRY DATE]
,sf_leiCode [LEI CODE]
,sfcesr.c_desc [CESR CLASS]
,sfgeo.gf_desc [GEO FOCUS]
,sfge.ge_desc [GLOBAL EXPOSURE]
,sf_currency [CURRENCY]
,nfreq.nf_desc [FREQUENCY]
,vdate.vd_desc [VALUATION DATE]
,cdate.cd_desc [CALCULATION DATE]
,case 
	when sf_derivatives=1 then 'YES'
	when sf_derivatives=0 then 'NO'
	else NULL
	END as [DERIVATIVES]
,dmar.dm_desc [DERIV. MARKET]
,dpur.dp_desc [DERIV. PURPOSE]
,sf_lastProspectus [LAST PROSPECTUS]
,sf_lastProspectusDate [LAST PROSPECTUS DATE]
,pac.pac_desc [PRINCIPAL ASSET CLASS]
,tom.tom_desc [MARKET TYPE]
,pis.pis_desc [PRINCIPAL INVESTMENT STRATEGY]
,sf_clearing_code [CLEARING CODE]
,cms.c_morningstar_desc [MORNINGSTAR CATEGORY]
,cs.cat_six_desc [SIX CATEGORY]
,cb.cat_bloomberg_Desc [BLOOMBERG CATEGORY]	

			FROM [dbo].tb_historySubFund sf
				left join tb_dom_sf_status sfstat on sfstat.st_id=sf.sf_status
				left join tb_dom_cesrClass sfcesr on sfcesr.cc_id=sf.sf_cesrClass
				left join tb_dom_cssf_geographical_focus sfgeo on sfgeo.gf_id=sf.sf_cssf_geographical_focus
				left join tb_dom_globalExposure sfge on sfge.ge_id=sf.sf_globalExposure
				left join tb_dom_navFrequency nfreq on nfreq.nf_id=sf.sf_navFrequency
				left join tb_dom_valutationDate vdate on vdate.vd_id=sf.sf_valutationDate
				left join tb_dom_calculationDate cdate on cdate.cd_id=sf.sf_calculationDate
				left join tb_dom_derivMarket dmar on dmar.dm_id=sf.sf_derivMarket
				left join tb_dom_derivPurpose dpur on dpur.dp_id=sf.sf_derivPurpose
				left join tb_dom_cssf_principal_asset_class pac on pac.pac_id=sf.sf_principal_asset_class
				left join tb_dom_type_of_market tom on tom.tom_id=sf.sf_type_of_market
				left join tb_dom_principal_investment_strategy pis on pis.pis_id=sf.sf_principal_investment_strategy
				left join tb_dom_sf_cat_morningstar cms on cms.c_morningstar_id=sf.sf_cat_morningstar
				left join tb_dom_sf_cat_six cs on cs.cat_six_id=sf.sf_category_six
				left join tb_dom_sf_cat_bloomberg cb on cb.cat_bloomberg_id=sf.sf_category_bloomberg
			Where (@report_date between sf.sf_initialDate and sf.sf_endDate OR (@report_date >= sf.sf_initialDate and sf.sf_endDate is null)) 
		 ) t3 ON t2.sf_id = t3.[ID] 
                 ORDER BY t3.[SUB FUND NAME]
)
GO
