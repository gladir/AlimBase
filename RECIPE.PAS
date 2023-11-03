{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program Recipe;

Uses Crt,Strings;

Type
 RecipeRec=Record
  Title:PChar;
  Ingrediant:PChar;
 End;

Const
 RecipeList:Array[0..13]of RecipeRec=(
  (Title:'Brochette aux boeufs';
   Ingrediant:'Boeuf,Oignon,Champignon,Piment rouge,Riz blanc'+
              'Salade,Oignon rouge,Concombre,Persil'),
  (Title:'Burger aux champignons';
   Ingrediant:'Pain … burger,Gros champignon,Oeuf bouillie,'+
   'Feuille d''‚pinard,Mayonnaise,Fromage suisse'),
  (Title:'Club Sandwich';
   Ingrediant:'Pain … sandwich,Poulet,Bacon,Tomate,Salade,Mayonnaise,'+
              'Salade de chou,Cornichon … l''aneth,Frite'),
  (Title:'Croque-monsieur';
   Ingrediant:'Pain sandwich,Bacon,Cheez Whiz,Olive verte'),
  (Title:'G‚n‚ral Tao';
   Ingrediant:'Riz,Poulet aux aigres douces'),
  (Title:'Hot Chicken';
   Ingrediant:'Pain sandwich,Poulet,Canne de petits poids,Frites'),
  (Title:'Hot Dog';
   Ingrediant:'Pain Hot Dog,Margarine,Saucisse … Hot Dog,'+
              'Relish,Moutarde,Frite,Ketchup,Salade de chou'),
  (Title:'Pƒte … tarte';
   Ingrediant:'5 tasses de farine tout usage,1 livre de graisse Crisco,'+
              '1 cuillŠre … table de sel,3/4 de tasse d''eau,oeuf,'+
              '1 cuillŠre … table de vingaire blanc ou jus de citron'),

  (Title:'Pƒt‚ … la viande';
   Ingrediant:'6 tasses de farine,1 livre graisse,2 tasses d''eau froide,'+
              '1 cuillŠre soupe de poudre … pate,'+
              'une pinc‚ de sel 1/4 cuillŠre,'+
              'Cuire le porc + 1 sachet de soupe … l''oignon,'+
              '400 Celcius 45 minutes'),
  (Title:'Poutine';
   Ingrediant:'Frites,Fromage,Sauce barbecues'),
  (Title:'Sauce … Spaghetti';
   Ingrediant:'Boeuf hach‚ mi-maigre,Huile d''olive,Epice … Spaghetti,'+
              'Pƒte tomate,Sauce tomate,Cube de tomate,'+
              'Sauce chili'+
              'Sel,Sucre,Poivre,'+
              'Ail,Carotte,Celeri,Oignon,Courgette,Poivron rouge,Champignon'),
  (Title:'Soupe … l''oignon';
   Ingrediant:'Oignon roti,Ail,Piment rouge,Eau,Bovril au boeuf,'+
   'Extr‚mit‚ d''un pain … sandwich,Fromage Cheddar ou Mozzarella rap‚,'+
   'Persil'),
  (Title:'Sous-marin';
   Ingrediant:'Pain … sous-marin,Viande … fondu au boeuf,'+
              'Fromage,Oignon,Salade,Piment,Tomate'),
  (Title:'Steak/Fites';
   Ingrediant:'Steak,Frites,Canne de petit pois vert')
 );

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I]in['‚','Š','ˆ',#232,#233,#234]Then S[I]:='E'Else
  If S[I]in['Œ',#238]Then S[I]:='I'Else
  If S[I]in[#131,#133,#224,#226]Then S[I]:='A'Else
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Var
 I,J,K:Integer;

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('RECIPE : Cette commande permet d''afficher une recette.');
  WriteLn;
  WriteLn('Syntaxe : RECIPE nom');
  WriteLn;
  WriteLn(' nom  Ce parametre permet d''indiquer le nom de la recette');
 End
  Else
 If ParamCount>0Then Begin
  For I:=1 to ParamCount do Begin
   For J:=Low(RecipeList) to High(RecipeList)do Begin
    If StrToUpper(ParamStr(I))=StrToUpper(StrPas(RecipeList[J].Title))Then Begin
     TextColor(White);
     WriteLn(StrToUpper(StrPas(RecipeList[J].Title)));
     WriteLn;
     TextColor(7);
     WriteLn('Liste des ingr‚dients :');
     Write(' - ');
     While RecipeList[J].Ingrediant[K]<>#0 do Begin
      If RecipeList[J].Ingrediant[K]=','Then Begin
       WriteLn;
       Write(' - ');
      End
       Else
      Begin
       Write(RecipeList[J].Ingrediant[K]);
      End;
      Inc(K);
     End;
     WriteLn;
    End;
   End;
  End;
 End;
END.