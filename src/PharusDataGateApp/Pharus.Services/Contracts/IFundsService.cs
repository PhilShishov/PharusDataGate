﻿
namespace Pharus.Services.Contracts
{
    using System;
    using System.Collections.Generic;

    using Pharus.Domain.Pharus_vFinale;

    public interface IFundsService
    {
        List<TbHistoryFund> GetAllFunds();

        List<string[]> GetAllActiveFunds();

        List<string[]> GetAllActiveFunds(DateTime? chosenDate);

        TbHistoryFund GetFund(string fundName);
    }
}
