VerificationTest[PartitionInto[Range[10], 2], {{1, 2, 3, 4, 5}, {6, 7, 8, 9, 10}}];
VerificationTest[PartitionInto[Range[10], 3], {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10}}];
VerificationTest[PartitionInto[Range[10], 3, "StrictMode" -> True], {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}];
