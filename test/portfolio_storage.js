const PortfolioStorage = artifacts.require("PortfolioStorage");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("PortfolioStorage", function (/* accounts */) {
  it("should update data", async function () {
    const portfolio = await PortfolioStorage.new()
    await portfolio.update(10);
    const data = await portfolio.read();
    assert(data.toString() == 10)
  });
});
