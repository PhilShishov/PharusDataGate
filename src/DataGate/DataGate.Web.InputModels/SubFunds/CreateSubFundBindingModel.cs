﻿namespace DataGate.Web.InputModels.SubFunds
{
    using System.ComponentModel.DataAnnotations;

    public class CreateSubFundBindingModel : SubFundBindingModel
    {
        [Required(ErrorMessage = "Please choose a fund container!")]
        [Display(Name = "Fund Container")]
        public string FundContainer { get; set; }
    }
}
