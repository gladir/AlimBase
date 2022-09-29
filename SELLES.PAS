{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program SELLES;

Uses Strings;

Type
 Color=Record
  Nom:PChar;
  Description:PChar;
 End;

 Aliment=Record
  Nom:PChar;
  Couleur:PChar;
 End;

Const
 Colors:Array[0..8]of Color=(
  (Nom:'Noir';
   Description:'M‚dicaments, du fer, un saignement digestif.'),
  (Nom:'Marron';
   Description:'ProblŠme de constipation'),
  (Nom:'Orange';
   Description:'Mauvaise digestion des matiŠres graisseuses'),
  (Nom:'Jaune';
   Description:'Mauvaise digestion du ma‹s ou mauvaise digestion des matiŠres graisseuses'),
  (Nom:'Blanc';
   Description:'Trop grande consommation de fromage, maladie du pancr‚as,...'),
  (Nom:'Blanchƒtres';
   Description:'Trop grande consommation de fromage, maladie du pancr‚as,...'),
  (Nom:'Rouge';
   Description:'Trop forte concentration de piment et nourriture trop ‚pic‚s, sang dans les selles.'),
  (Nom:'Vert';
   Description:'TrŠs forte concentration de l‚gumes'),
  (Nom:'Brun';
   Description:'Couleur d''une bonne digestion')
 );

 Aliments:Array[0..1]of Aliment=(
  (Nom:'Fromage';
   Couleur:'Blanc, blanchƒtre ou brun'),
  (Nom:'Fer';
   Couleur:'Noir')
 );


Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Var
 I,J:Integer;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('SELLES : Cette commande permet d''indiquer ',
                   ' la couleur … laquelle certains aliments sortes ou ',
                   'que signifie la couleur d''un seul');
  WriteLn;
  WriteLn('Syntaxe : SELLES couleur');
  WriteLn('          SELLES aliment');
  WriteLn;
  WriteLn(' couleur      Ce parametre permet d''indiquer la signification de la couleur');
  WriteLn(' aliment      Ce parametre permet d''indiquer l''aliment … d‚terminer');
 End
  Else
 If ParamCount>0Then Begin
   For I:=1 to ParamCount do Begin
    For J:=Low(Colors) to High(Colors)do Begin
     If StrToUpper(ParamStr(I))=(StrToUpper(StrPas(Colors[J].Nom)))Then Begin
      Write('Couleur : ');
      WriteLn(StrPas(Colors[J].Nom));
      Write('Description : ');
      WriteLn(StrPas(Colors[J].Description));
      Break;
     End;
    End;
    For J:=Low(Aliments) to High(Aliments)do Begin
     If StrToUpper(ParamStr(I))=(StrToUpper(StrPas(Aliments[J].Nom)))Then Begin
      Write('Nom : ');
      WriteLn(StrPas(Aliments[J].Nom));
      Write('Description : ');
      WriteLn(StrPas(Aliments[J].Couleur));
      Break;
     End;
    End;
   End;
 End;
END.