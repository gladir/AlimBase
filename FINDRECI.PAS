{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program FindReci;

Uses Strings;

Const
 FoodList:Array[0..20]of PChar=(
  'Brochette aux boeufs',
  'Brochette aux poulets',
  'Brochette Slovaquie',
  'Burger aux champignons',
  'Club sandwitch',
  'C“telette de porc',
  'Croque-monsieur',
  'Hot Chicken',
  'Hot Dog',
  'G‚n‚ral Tao',
  'Pƒt‚ chinois',
  'Pƒt‚ … la viande',
  'Pizza',
  'Poutine',
  'Soupe … l''oignon',
  'Sous-marin',
  'Spaghetti',
  'Spaghetti gratin‚',
  'Steak/Fites',
  'TourtiŠre','Tourtiere'
 );

Var
 LineNumber:LongInt;
 Option:Set of (_Lines);
 BeginWord,I,J:Integer;
 FoundMultiWord:Boolean;
 SourceFile:Text;
 FileName,CurrLine,CurrWord:String;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function IsLetter(Chr:Char):Boolean;Begin
 IsLetter:=Chr in ['A'..'Z','a'..'z','‚','ˆ','Š','…','ƒ','“','‡'];
End;

Procedure CompileWord;
Var
 I:Integer;
Begin
 For I:=Low(FoodList) to High(FoodList) do Begin
  If StrToUpper(StrPas(FoodList[I]))=StrToUpper(CurrWord)Then Begin
   If FileName<>''Then Begin
    If(_Lines in Option)Then Begin
     WriteLn('Avion trouve dans la ligne numero ',LineNumber,' :');
    End;
   End;
   WriteLn(StrPas(FoodList[I]));
   Exit;
  End;
 End;
End;

Procedure ParseLineDetectPlane;
Var
 J:Integer;
Begin
 CurrWord:='';
 BeginWord:=1;
 For I:=1 to Length(CurrLine)do Begin
  If(IsLetter(CurrLine[I]))Then CurrWord:=CurrWord+CurrLine[I]
   Else
  Begin
   FoundMultiWord:=False;
   For J:=Low(FoodList) to High(FoodList) do Begin
    If(StrLen(FoodList[J])>Length(CurrWord))and
      (StrToUpper(StrPas(FoodList[J]))=
      StrToUpper(Copy(CurrLine,BeginWord,StrLen(FoodList[J]))))Then Begin
     FoundMultiWord:=True;
     Break;
    End;
   End;
   If(FoundMultiWord)Then Begin
    CurrWord:=CurrWord+CurrLine[I]
   End
    Else
   Begin
    CompileWord;
    CurrWord:='';
    BeginWord:=I+1;
   End;
  End;
 End;
 CompileWord;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('FINDRECI : Cette commande permet de d‚tecter les recettes ',
                      'mentionn‚ dans un texte.');
  WriteLn;
  WriteLn('Syntaxe : FINDRECI "message"');
  WriteLn('          FINDRECI /FILE:fichier [/LINES]');
  WriteLn;
  WriteLn(' /FILE:  Ce parametre permet d''indiquer le fichier a analyser');
  WriteLn(' /LINES  Ce parametre permet d''afficher le numero de ligne');
 End
  Else
 Begin
  Option:=[];
  LineNumber:=0;
  FileName:='';
  CurrLine:='';
  For I:=1 to ParamCount do Begin
   If StrToUpper(ParamStr(I))='/LINES'Then Include(Option,_Lines);
   If StrToUpper(Copy(ParamStr(I),1,6))='/FILE:'Then Begin
    FileName:=Copy(ParamStr(I),7,255);
   End
    Else
   Begin
    If CurrLine=''Then CurrLine:=ParamStr(I)
                  Else CurrLine:=CurrLine+' '+ParamStr(I);
   End;
  End;
  If FileName<>''Then Begin
    Assign(SourceFile,FileName);
    Reset(SourceFile);
    While Not EOF(SourceFile)do Begin
     Inc(LineNumber);
     ReadLn(SourceFile,CurrLine);
     ParseLineDetectPlane;
    End;
    Close(SourceFile);
   End
    Else
   ParseLineDetectPlane;
 End;
END.

