Reporter Usage:


Easy Way to Test:

% cabal repl executable:reporter
> conn <- connect "hrr.db"
> run conn () allDbRecord
SQL: SELECT ALL T0.id AS f0, T0.filename AS f1, T0.p1 AS f2, T0.p2 AS f3, T0.p3 AS f4, T0.p4 AS f5, T0.p5 AS f6, T0.p6 AS f7, T0.p7 AS f8, T0.p8 AS f9, T0.p9 AS f10, T0.p10 AS f11, T0.p11 AS f12, T0.p12 AS f13, T0.p13 AS f14, T0.p14 AS f15, T0.p15 AS f16, T0.p16 AS f17, T0.p17 AS f18, T0.p18 AS f19, T0.p19 AS f20, T0.p20 AS f21 FROM MAIN.db_record T0
DbRecord {id = Just 1, filename = "20.csv", p1 = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20", p2 = "", p3 = "", p4 = "", p5 = "", p6 = "", p7 = "", p8 = "", p9 = "", p10 = "", p11 = "", p12 = "", p13 = "", p14 = "", p15 = "", p16 = "", p17 = "", p18 = "", p19 = "", p20 = ""}
DbRecord {id = Just 2, filename = "20.csv", p1 = "10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200", p2 = "", p3 = "", p4 = "", p5 = "", p6 = "", p7 = "", p8 = "", p9 = "", p10 = "", p11 = "", p12 = "", p13 = "", p14 = "", p15 = "", p16 = "", p17 = "", p18 = "", p19 = "", p20 = ""}
...
