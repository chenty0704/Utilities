Get["Utilities`QuantityUtilities`"];

VerificationTest[
    QuantityDifferences@{Quantity[1, "Meters"], Quantity[1, "Meters"], Quantity[2, "Meters"]},
    {Quantity[0, "Meters"], Quantity[1, "Meters"]}
];

VerificationTest[
    QuantityDifferences@QuantityArray[{1, 1, 2}, "Meters"],
    QuantityArray[{0, 1}, "Meters"]
];

VerificationTest[
    QuantityTotal[{Quantity[1, "Meters"], Quantity[2, "Meters"], Quantity[3, "Meters"]}, "Meters"],
    Quantity[6, "Meters"]
];

VerificationTest[
    QuantityTotal[QuantityArray[{1, 2, 3}, "Meters"], "Meters"],
    Quantity[6, "Meters"]
];

VerificationTest[
    QuantityTotal[{}, "Meters"],
    Quantity[0, "Meters"]
];
