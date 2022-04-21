const Payments = artifacts.require("Payments");

contract("Payments", function (/* accounts */) {
  it("should be deployed", async function () {
    await Payments.deployed();
    return assert.isTrue(true);
  });
});
