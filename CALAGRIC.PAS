{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program CALAGRIC;

Uses DOS,Strings;

Type
 CultureRec=Record
  Name:PChar;
  HeightCmMin,HeightCmMax:Real;
  SeedSpacingMin,SeedSpacingMax:Real;
  RowSpacingMin,RowSpacingMax:Real;
  SeedDepthCmMin,SeedDepthCmMax:Real;
  MaturityDays:Word;
  Soil:Set of (Fertile,Light,Loose,Moist,Neutral,Rich,
  WellDraining,WellFertilized,WellWorked);
  Sun:Set of (PartSun,FullSun);
  GerminationDayMin,GerminationDayMax:Word;
 End;

Const
 Culture:Array[0..19]of CultureRec=(
  (Name:'Betteraves';HeightCmMin:30;HeightCmMax:38;
   SeedSpacingMin:5;SeedSpacingMax:10;
   RowSpacingMin:30;RowSpacingMax:45;
   SeedDepthCmMin:1.2;SeedDepthCmMax:1.2;
   MaturityDays:63;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:8;GerminationDayMax:10),
  (Name:'Carottes';HeightCmMin:45;HeightCmMax:55;
   SeedSpacingMin:5;SeedSpacingMax:7;
   RowSpacingMin:30;RowSpacingMax:35;
   SeedDepthCmMin:0.5;SeedDepthCmMax:1.5;
   MaturityDays:90;
   Soil:[Loose];
   Sun:[FullSun];
   GerminationDayMin:8;GerminationDayMax:10),
  (Name:'Celeri';HeightCmMin:22;HeightCmMax:25;
   SeedSpacingMin:20;SeedSpacingMax:25;
   RowSpacingMin:60;RowSpacingMax:60;
   SeedDepthCmMin:0.6;SeedDepthCmMax:1.2;
   MaturityDays:90;
   Soil:[Rich,WellDraining];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:21),
  (Name:'Chou';HeightCmMin:45;HeightCmMax:45;
   SeedSpacingMin:45;SeedSpacingMax:60;
   RowSpacingMin:60;RowSpacingMax:90;
   SeedDepthCmMin:1.2;SeedDepthCmMax:1.2;
   MaturityDays:100;
   Soil:[Fertile,Neutral];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10),
  (Name:'Chou-fleurs';HeightCmMin:60;HeightCmMax:72;
   SeedSpacingMin:45;SeedSpacingMax:45;
   RowSpacingMin:60;RowSpacingMax:60;
   SeedDepthCmMin:0.6;SeedDepthCmMax:0.6;
   MaturityDays:70;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:8;GerminationDayMax:10),
  (Name:'Chou fris‚';HeightCmMin:30;HeightCmMax:45;
   SeedSpacingMin:15;SeedSpacingMax:30;
   RowSpacingMin:30;RowSpacingMax:45;
   SeedDepthCmMin:1.25;SeedDepthCmMax:1.25;
   MaturityDays:55;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:5;GerminationDayMax:8),
  (Name:'Citrouille';HeightCmMin:200;HeightCmMax:200;
   SeedSpacingMin:45;SeedSpacingMax:45;
   RowSpacingMin:122;RowSpacingMax:183;
   SeedDepthCmMin:2.5;SeedDepthCmMax:2.5;
   MaturityDays:120;
   Soil:[Rich,WellDraining];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10),
  (Name:'Concombres';HeightCmMin:30;HeightCmMax:45;
   SeedSpacingMin:45;SeedSpacingMax:60;
   RowSpacingMin:240;RowSpacingMax:240;
   SeedDepthCmMin:1.3;SeedDepthCmMax:1.3;
   MaturityDays:60;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:8;GerminationDayMax:10),
  (Name:'Courges';HeightCmMin:30;HeightCmMax:30;
   SeedSpacingMin:45;SeedSpacingMax:60;
   RowSpacingMin:200;RowSpacingMax:200;
   SeedDepthCmMin:2.5;SeedDepthCmMax:2.5;
   MaturityDays:75;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10),
  (Name:'Courgettes';HeightCmMin:30;HeightCmMax:60;
   SeedSpacingMin:45;SeedSpacingMax:60;
   RowSpacingMin:90;RowSpacingMax:120;
   SeedDepthCmMin:2;SeedDepthCmMax:2;
   MaturityDays:50;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10),
  (Name:'Epinard';HeightCmMin:20;HeightCmMax:20;
   SeedSpacingMin:15;SeedSpacingMax:15;
   RowSpacingMin:30;RowSpacingMax:45;
   SeedDepthCmMin:2.5;SeedDepthCmMax:4;
   MaturityDays:42;
   Soil:[Light,WellDraining];
   Sun:[PartSun,FullSun];
   GerminationDayMin:5;GerminationDayMax:9),
  (Name:'Haricots';HeightCmMin:45;HeightCmMax:45;
   SeedSpacingMin:10;SeedSpacingMax:15;
   RowSpacingMin:30;RowSpacingMax:45;
   SeedDepthCmMin:2.5;SeedDepthCmMax:2.5;
   MaturityDays:51;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:8;GerminationDayMax:10),
  (Name:'Laitue';HeightCmMin:30;HeightCmMax:30;
   SeedSpacingMin:15;SeedSpacingMax:15;
   RowSpacingMin:30;RowSpacingMax:45;
   SeedDepthCmMin:0.3;SeedDepthCmMax:0.3;
   MaturityDays:72;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10),
  (Name:'Laitue Simpson';HeightCmMin:15;HeightCmMax:18;
   SeedSpacingMin:10;SeedSpacingMax:15;
   RowSpacingMin:30;RowSpacingMax:45;
   SeedDepthCmMin:0.0;SeedDepthCmMax:0.5;
   MaturityDays:45;
   Soil:[WellDraining];
   Sun:[FullSun,PartSun];
   GerminationDayMin:7;GerminationDayMax:14),
  (Name:'Ma‹s';HeightCmMin:2;HeightCmMax:2.5;
   SeedSpacingMin:7.5;SeedSpacingMax:7.5;
   RowSpacingMin:60;RowSpacingMax:90;
   SeedDepthCmMin:2.0;SeedDepthCmMax:5.0;
   MaturityDays:63;
   Soil:[WellFertilized];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10),
  (Name:'Petits pois';HeightCmMin:200;HeightCmMax:200;
   SeedSpacingMin:2.5;SeedSpacingMax:2.5;
   RowSpacingMin:45;RowSpacingMax:60;
   SeedDepthCmMin:2.5;SeedDepthCmMax:2.5;
   MaturityDays:70;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:15;GerminationDayMax:15),
  (Name:'Piments';HeightCmMin:50;HeightCmMax:60;
   SeedSpacingMin:30;SeedSpacingMax:45;
   RowSpacingMin:50;RowSpacingMax:60;
   SeedDepthCmMin:0.5;SeedDepthCmMax:1.0;
   MaturityDays:75;
   Soil:[WellDraining];
   Sun:[FullSun,PartSun];
   GerminationDayMin:7;GerminationDayMax:21),
  (Name:'Radis';HeightCmMin:15;HeightCmMax:20;
   SeedSpacingMin:5;SeedSpacingMax:10;
   RowSpacingMin:30;RowSpacingMax:30;
   SeedDepthCmMin:1.2;SeedDepthCmMax:1.2;
   MaturityDays:27;
   Soil:[WellWorked,Moist];
   Sun:[FullSun];
   GerminationDayMin:5;GerminationDayMax:7),
  (Name:'Tomate';HeightCmMin:90;HeightCmMax:120;
   SeedSpacingMin:60;SeedSpacingMax:60;
   RowSpacingMin:90;RowSpacingMax:120;
   SeedDepthCmMin:0.5;SeedDepthCmMax:0.5;
   MaturityDays:95;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:5;GerminationDayMax:10),
  (Name:'Tomate cerise';HeightCmMin:150;HeightCmMax:200;
   SeedSpacingMin:60;SeedSpacingMax:60;
   RowSpacingMin:90;RowSpacingMax:90;
   SeedDepthCmMin:0.6;SeedDepthCmMax:1.2;
   MaturityDays:80;
   Soil:[WellDraining];
   Sun:[FullSun];
   GerminationDayMin:7;GerminationDayMax:10)
 );

Var
 CurrCulture,CountDays,DayStart:Integer;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I]in['‚','Š','ˆ',#232,#233,#234]Then S[I]:='E'Else
  If S[I]in['Œ',#238]Then S[I]:='I'Else
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function IsLeapYear(Year:Integer):Boolean;Begin
 IsLeapYear:=((Year AND 3) = 0) AND ((Year MOD 100 <> 0) OR (Year MOD 400 = 0));
End;

Function DateToDayOfWeek(Y,M,D:Integer):Integer;
Var
 T0,T1,T2,Total:Integer;
Begin
 If(M > 12) Or (0 = M) Or (0 = D)Then Begin
  DateToDayOfWeek:=0;Exit;
 End;
 If Y < 0 Then Inc(Y);
 T0 := Trunc(0.6 + 1 / M);
 T1 := M + 12 * T0;
 T2 := Y - T0;
 Total := Trunc(13 * (T1 + 1) / 5) + (5 * T2 div 4) - (T2 div 100) + (T2 div 400) + D - 1;
 DateToDayOfWeek := Total - 7 * (Total div 7);
End;

Procedure PutCalendar(Yr,Mh,Dy:Integer);
Const
 Days:Array[1..12] of Integer=(31,28,31,30,31,30,31,31,30,31,30,31);
Var
 I,J,D,K:Integer;
 LineCulture:Array[Low(Culture)..High(Culture),0..8]of (None,Semer,Germination,Maturity);
Begin
 If IsLeapYear(Yr)Then Days[2] := 29;
 D := DateToDayOfWeek(Yr, Mh, 1);
 WriteLn('Dimanche Lundi    Mardi    Mercredi Jeudi    Vendredi Samedi');
 Write(' ':9 * D);
 FillChar(LineCulture,SizeOf(LineCulture),0);
 For I:=1 To Days[Mh]do Begin
  If DayStart>0 Then Begin
   Dec(DayStart);
  End
   Else
  Inc(CountDays);
  If(CountDays=1)Then Begin
   LineCulture[CurrCulture,((D + I) Mod 7)]:=Semer;
  End
   Else
  If(Culture[CurrCulture].GerminationDayMin<=CountDays)and
    (Culture[CurrCulture].GerminationDayMax>=CountDays)Then Begin
   LineCulture[CurrCulture,((D + I) Mod 7)]:=Germination;
  End
   Else
  If(Culture[CurrCulture].MaturityDays=CountDays)Then Begin
   LineCulture[CurrCulture,((D + I) Mod 7)]:=Maturity;
  End;
  If I < 10 Then Write(' ');
  Write(I,' ':7);
  If(0 =((D + I) Mod 7))Then Begin
   WriteLn;
   For J:=0 to 6 do Begin
    Case LineCulture[CurrCulture,(J+1)mod 7]of
     Semer:Write('Semer    ');
     Germination:Write('Germin.  ');
     Maturity:Write('Maturit‚ ');
     Else Write(' ':9);
    End;
   End;
   WriteLn;
   FillChar(LineCulture,SizeOf(LineCulture),0);
  End;
 End;
 WriteLn;
 WriteLn;
End;

Function MonthName(Mh:Integer):String;Begin
 Case Mh of
   1:MonthName:='Janvier';
   2:MonthName:='F‚vrier';
   3:MonthName:='Mars';
   4:MonthName:='Avril';
   5:MonthName:='Mai';
   6:MonthName:='Juin';
   7:MonthName:='Juillet';
   8:MonthName:='Ao–t';
   9:MonthName:='Septembre';
   10:MonthName:='Octobre';
   11:MonthName:='Novembre';
   12:MonthName:='D‚cembre';
   Else MonthName:='';
 End;
End;

Var
 CurrYear,CurrMonth,CurrDay,DayOfWeek,Err,I,J:Word;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('CALAGRIC : Cette commande permet d''afficher un ',
                'calendrier agricole.');
  WriteLn;
  WriteLn('Syntaxe : CALAGRIC legume [jour] [mois] [annee]');
  WriteLn;
  WriteLn(' legume   Ce paramŠtre permet d''indiquer le nom du l‚gume');
  WriteLn(' jour     Ce paramŠtre permet d''indiquer le jour du mois');
  WriteLn(' mois     Ce paramŠtre permet d''indiquer le num‚ro du mois');
  WriteLn(' annee    Ce paramŠtre permet d''indiquer l''ann‚e');
 End
  Else
 If ParamCount>0Then Begin
  CountDays:=0;
  CurrCulture:=-1;
  DayStart:=0;
  For J:=Low(Culture) to High(Culture)do Begin
   If StrToUpper(StrPas(Culture[J].Name))=StrToUpper(ParamStr(1))Then Begin
    CurrCulture:=J;
   End;
  End;
  If ParamStr(2)<>''Then Begin
   Val(ParamStr(2),DayStart,Err);
   If DayStart>0 Then Dec(DayStart);
  End;
  GetDate(CurrYear,CurrMonth,CurrDay,DayOfWeek);
  If ParamStr(3)<>''Then Begin
   Val(ParamStr(3),CurrMonth,Err);
  End;
  If ParamStr(4)<>''Then Begin
   Val(ParamStr(4),CurrYear,Err);
  End;
  WriteLn(MonthName(CurrMonth),' ',CurrYear);
  WriteLn;
  Inc(CurrMonth);
  If CurrMonth=13 Then Begin
   CurrMonth:=1;
   Inc(CurrYear);
  End;
  PutCalendar(CurrYear,CurrMonth,CurrDay);
  WriteLn(MonthName(CurrMonth),' ',CurrYear);
  WriteLn;
  PutCalendar(CurrYear,CurrMonth,CurrDay);
 End
  Else
 WriteLn('ParamŠtre requis');
END.