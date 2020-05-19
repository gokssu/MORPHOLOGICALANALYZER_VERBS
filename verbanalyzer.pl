%G�ksu EREN-151805043
:- include('C:/Users/en_ya/Desktop/weak_vowel_harmonizer.pl').
%Finite-state automaton.
initial(q1).
final(q1).
final(q2).
final(q3a).
final(q3b).
final(q3c).
final(q4a).
final(q4b).
final(q5).

t(q0,true,q1).
t(q1,verb,q2).
t(q2,neg,q3a).
t(q2,tense,q3b).
t(q2,defpast,q3c).
t(q3a,tense,q3b).
t(q3a,defpast,q3c).
t(q3a,person,q5).
t(q3b,indpast,q4a).
t(q3b,defpast,q4b).
t(q3b,person,q5).
t(q3c,defpast,q4b).
t(q3c,person,q5).
t(q4a,person,q5).
t(q4b,person,q5).
t(q5,defpast,q4b).
%Metinde se�ti�im fiiller
morpheme(verb,gel).
morpheme(verb,ayr�l).
morpheme(verb,kilitle).
morpheme(verb,konu�).
morpheme(verb,unut).
morpheme(verb,ist).
morpheme(verb,kal).
morpheme(verb,al).
%duyulan ge�mi� zaman
morpheme(tense,m��).
morpheme(tense,mi�).
morpheme(tense,mu�).
morpheme(tense,m��).
% �imdi ki zaman
morpheme(tense,iyor).
morpheme(tense,�yor).
morpheme(tense,uyor).
morpheme(tense,�yor).
morpheme(tense,yor).
% gelecek zaman
morpheme(tense,ecek).
morpheme(tense,acak).
morpheme(tense,yecek).
morpheme(tense,yacak).
% geni� zaman
morpheme(tense,�r).
morpheme(tense,ir).
morpheme(tense,ur).
morpheme(tense,�r).
morpheme(tense,ar).
morpheme(tense,er).
% istek kipi
morpheme(tense,e).
morpheme(tense,a).
morpheme(tense,ye).
morpheme(tense,ya).
% gereklilik kipi
morpheme(tense,meli).
morpheme(tense,mal�).
morpheme(tense,meliy).
morpheme(tense,mal�y).
% �art kipi
morpheme(tense,se).
morpheme(tense,sa).
morpheme(tense,sey).
morpheme(tense,say).
% g�r�len ge�mi� zaman
morpheme(defpast,di).
morpheme(defpast,d�).
morpheme(defpast,du).
morpheme(defpast,d�).
morpheme(defpast,ydi).
morpheme(defpast,yd�).
morpheme(defpast,ydu).
morpheme(defpast,yd�).
morpheme(defpast,ti).
morpheme(defpast,t�).
morpheme(defpast,tu).
morpheme(defpast,t�).
% olumsuzluk ekleri
morpheme(neg,me).
morpheme(neg,ma).
morpheme(neg,mu).
morpheme(neg,m�).
morpheme(neg,mi).
morpheme(neg,m�).
% duyulan ge�mi� zaman(rivayet birle�ik fiilleri i�in)
morpheme(indpast,m��).
morpheme(indpast,mi�).
morpheme(indpast,mu�).
morpheme(indpast,m��).
% �ah�s ekleri
%birinci tekil
morpheme(person,m).
morpheme(person,�m).
morpheme(person,im).
morpheme(person,um).
morpheme(person,�m).
morpheme(person,y�m).
morpheme(person,yim).
morpheme(person,yum).
morpheme(person,y�m).
%ikinci tekil
morpheme(person,n).
morpheme(person,�n).
morpheme(person,in).
morpheme(person,un).
morpheme(person,�n).
morpheme(person,s�n).
morpheme(person,sin).
morpheme(person,s�n).
morpheme(person,sun).
%birinci �o�ul
morpheme(person,�z).
morpheme(person,iz).
morpheme(person,uz).
morpheme(person,�z).
morpheme(person,�k).
morpheme(person,ik).
morpheme(person,y�z).
morpheme(person,yiz).
morpheme(person,yuz).
morpheme(person,y�z).
%ikinci �o�ul
morpheme(person,�n�z).
morpheme(person,iniz).
morpheme(person,unuz).
morpheme(person,�n�z).
morpheme(person,s�n�z).
morpheme(person,siniz).
morpheme(person,sunuz).
morpheme(person,s�n�z).
%���nc� �o�ul
morpheme(person,lar).
morpheme(person,ler).


turkishverb(String,Morphemes) :-
                            initial(State),
                            turkishverb(String,State,Morphemes).
turkishverb('',State,[]) :-
                            final(State).

turkishverb(String,State,[Morpheme|Rest_Of_Morphemes]) :-
       concat(Allomorph,Rest,String),
       morpheme(Morpheme,Allomorph),
       t(State,Morpheme,NextState),
       (not(Rest = '') ->
       (harmony_suffixal_prefix(Rest,Segment),
        concat(Allomorph,Segment,Substring),
        weakly_harmonize(Substring)); true),
      turkishverb(Rest,NextState,Rest_Of_Morphemes).
       
harmony_suffixal_prefix(Rest,Char):-
   string_to_list(Rest,[Code|_]),
   char_code(Char,Code),
   vowel(Char).

harmony_suffixal_prefix(Rest,Segment):-
   string_to_list(Rest,[Code1,Code2|_]),
   char_code(Char1,Code1),
   char_code(Char2,Code2),
   consonant(Char1),
   vowel(Char2),
   concat(Char1,Char2,Segment).
