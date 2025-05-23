using System.Text.Json;
using Microsoft.JSInterop;

namespace FinanceDashboard.Services
{
    public class TransactionStorageService
    {
        private readonly IJSRuntime js;
        private const string StorageKey = "transactions";

        public TransactionStorageService(IJSRuntime js)
        {
            this.js = js;
        }

        public async Task<List<Transaction>> LoadAsync()
        {
            return await js.InvokeAsync<List<Transaction>>("transactionStorage.load", StorageKey);
        }

        public async Task SaveAsync(List<Transaction> transactions)
        {
            await js.InvokeVoidAsync("transactionStorage.save", StorageKey, transactions);
        }
    }

    public class Transaction
    {
        public string Description { get; set; } = "";
        public decimal Amount { get; set; }
        public string Type { get; set; } = "Income";
    }
}
