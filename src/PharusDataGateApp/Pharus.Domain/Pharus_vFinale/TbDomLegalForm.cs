﻿using System;
using System.Collections.Generic;

namespace Pharus.Domain.Pharus_vFinale
{
    public partial class TbDomLegalForm
    {
        public TbDomLegalForm()
        {
            TbHistoryFund = new HashSet<TbHistoryFund>();
        }

        public int LfId { get; set; }
        public string LfAcronym { get; set; }

        public virtual ICollection<TbHistoryFund> TbHistoryFund { get; set; }
    }
}
