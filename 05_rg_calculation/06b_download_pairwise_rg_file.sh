export PROD=TRUE
  
run_ldscore_report \
--rg \
--gwas-id 66,123,309,346,439,698,706,731,756,835,857,866,876,1044,1068,1073,1079,1086,1092,1118,1136,1150,1170,1207,1225,1256,1309,1321,1329,1345,1354,1357,1360,1365,1371,1377,1381,1383,1389,1395,1399,1401,1403,1407,1411,1413,1417,1419,1426,1432,1435,1437,1444,1447,1449,1459,1462,1463,1502,1513,1518,1529,1530,1547,1568,1573,1586,1591,1596,1597,1603,1615,1652,1663,1830,1931,2024,2032,2173,2330,3429,3458,3478,3497,3543,3575,3728,3762,3777,3780,3789,3792,3799,3801,3807,3818,3824,3829,3835,3838,3856,3868,3872,3874,3884,3889,3894,3896,3900,3906,3909,3918,3924,3927,3936,3939,3943,3955,3958,3978,3981,3990,3999,4008,4014,4020,4032,4049,4051,4052,4054,4056,4058,4060,4061,4068,4069,4082,4084,4092,4093,4095,4096,4099,4101,4105,4106,4115,4116,4119,4120,4123,4127,4129,4133,4134,4136,4140,4144,4150,4153,4154,4155,4157,4161,4170,4174,4177,4178,4179,4184,4195,4204,4205,4206,4207,4208,4211,4212,4216,4218,4221,4231,4236,4237,4240,4249,4253,4264,4299,4461,4462,4463,4464,4465,4466,4467,4469,4470,4472,4473,4474,4475,4491,4492,4493,4494,4495,4507,4508,4509,4510,4511,4513,4514,4515,4516,4517,4520,4521,4525,4529,4532,4534,4535,4536,4537,4539,1282537,1282657,1282658,1282659,1282660,1287006 \
--output-dir /home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS \
--output-file paiwise_ld_matrix 
