VerificationTest[F["PositiveInteger: `D3`", 5], "PositiveInteger: 005"];
VerificationTest[F["NegativeInteger: `D3`", -5], "NegativeInteger: -005"];
VerificationTest[F["Real: `F2`", 0.1234], "Real: 0.12"];
VerificationTest[F["Real: `F2`", 1234.], "Real: 1234.00"];

VerificationTest[ToPascalCase["pascal case"], "PascalCase"];
