import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const VotingModule = buildModule("VotingModule", (m) => {
  const VotingSystem = m.contract("VotingSystem");

  return { VotingSystem };
});

module.exports = VotingModule;