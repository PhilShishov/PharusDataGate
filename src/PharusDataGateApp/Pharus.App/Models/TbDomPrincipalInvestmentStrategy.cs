﻿using System;
using System.Collections.Generic;

namespace Pharus.App.Models
{
    public partial class TbDomPrincipalInvestmentStrategy
    {
        public TbDomPrincipalInvestmentStrategy()
        {
            TbHistorySubFund = new HashSet<TbHistorySubFund>();
        }

        public int PisId { get; set; }
        public string PisDesc { get; set; }

        public virtual ICollection<TbHistorySubFund> TbHistorySubFund { get; set; }
    }
}
