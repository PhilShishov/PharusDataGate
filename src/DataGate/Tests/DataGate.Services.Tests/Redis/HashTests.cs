﻿namespace DataGate.Services.Tests.Redis
{
    using System;
    using System.Threading.Tasks;

    using StackExchange.Redis;
    using Xunit;

    using DataGate.Common;
    using DataGate.Services.Redis;
    using DataGate.Services.Tests.ClassFixtures;
    using DataGate.Services.Tests.TestData;

    public class HashTests : IClassFixture<RedisFixture>, IDisposable
    {
        private readonly RedisContainer container;
        private readonly RedisValueHash hashItem;

        public HashTests(RedisFixture fixture)
        {
            this.container = new RedisContainer(fixture.RedisConnection, GlobalConstants.TestHashContainer);
            this.hashItem = new RedisValueHash("hashkey");
            this.container.AddToContainer(this.hashItem);
        }

        public void Dispose()
        {
            this.container.DeleteTrackedKeys().Wait();
        }

        [Theory]
        [ClassData(typeof(HashDataGenerator))]
        public async Task Set_WithKeyNameAndValueOfDifferentType_ShouldCreateHashKey(string itemName, object value)
        {
            RedisValue redisValue = RedisObject.ToRedisValue(value);
            await this.hashItem.Set(itemName, redisValue);

            var actual = this.hashItem.Get(itemName).Result;
            var expected = redisValue;

            Assert.True(await this.hashItem.ContainsKey(itemName));
            Assert.Equal(expected, actual);
        }

        [Theory]
        [InlineData(null)]
        [InlineData("")]
        [InlineData("       ")]
        public void ToRedisValue_WithInvalidValue_ShouldThrowException(object value)
        {
            Action act = () => RedisObject.ToRedisValue(value);

            Assert.Throws<ArgumentException>(act);
        }

        [Theory]
        [InlineData(null, "emptykey")]
        [InlineData("", "emptykeytext")]
        [InlineData("               ", "largeemptykeytext")]
        public async Task Set_WithInvalidNameAndValidStringValue_ShouldThrowException(string itemName, object value)
        {
            RedisValue redisValue = RedisObject.ToRedisValue(value);

            Func<Task> task = async () => await this.hashItem.Set(itemName, redisValue);

            await Assert.ThrowsAsync<ArgumentException>(task);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(5)]
        public async Task Increment_WithIncreaseValue_ShouldIncrease(long increase)
        {
            string itemNameInt = "numbers";
            await this.hashItem.Set(itemNameInt, 100);

            var actual = await this.hashItem.Increment(itemNameInt, increase);
            var expected = 100 + increase;

            Assert.Equal(expected, actual);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(5)]
        public async Task Decrement_WithDecreaseValue_ShouldDecrease(long decrease)
        {
            string itemNameInt = "numbers";
            await this.hashItem.Set(itemNameInt, 100);

            var actual = await this.hashItem.Decrement(itemNameInt, decrease);
            var expected = 100 - decrease;

            Assert.Equal(expected, actual);
        }

        [Fact]
        public async Task Remove_ShouldDeleteItemFromContainer()
        {
            var itemName = "todelete";
            await this.hashItem.Set(itemName, "todeletevalue");

            var actual = await this.hashItem.Remove(itemName);
            var expected = true;

            Assert.Equal(expected, actual);
            Assert.False(await hashItem.ContainsKey(itemName));
        }

        [Fact]
        public async Task Count_ShouldReturnCorrectNumberOfItems()
        {
            await this.hashItem.Set("link", "https://github.com");
            await this.hashItem.Set("numbers", 88);
            await this.hashItem.Set("time", DateTime.Now.Ticks);

            await foreach (var field in this.hashItem)
            {
                Console.WriteLine($"{field.Key} = {field.Value}");
            }

            var actual = await this.hashItem.Count();
            var expected = 3;

            Assert.Equal(expected, actual);

        }
    }
}