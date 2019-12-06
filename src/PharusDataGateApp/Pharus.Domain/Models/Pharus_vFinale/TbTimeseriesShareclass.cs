﻿namespace Pharus.Domain.Models.Pharus_vFinale
{
    using System;

    public partial class TbTimeseriesShareclass
    {
        public DateTime DateTs { get; set; }

        public int IdTs { get; set; }

        public decimal? ValueTs { get; set; }

        public string CurrencyTs { get; set; }

        public int ProviderTs { get; set; }

        public int IdShareclass { get; set; }

        public virtual TbDomIsoCurrency CurrencyTsNavigation { get; set; }

        public virtual TbShareClass IdShareclassNavigation { get; set; }

        public virtual TbDomTimeseriesType IdTsNavigation { get; set; }

        public virtual TbDomTimeseriesProvider ProviderTsNavigation { get; set; }
    }
}