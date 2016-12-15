% Squadron(-Solution)
% @param Solution is a list of houses that satisfy all constraints.
% @author Willian Lauber
% @see https://rachacuca.com.br/logica/problemas/esquadrilha-de-avioes/

%pesquisas
% @param Bebidae é o parametro de busca, digita-se Piloto(com p maiusculo) e o nome de uma bebida.
% @retorn é retornado quem bebe tal bebida, se nimguem beber ela retorna falso.Obs funciona para encontrar o que bebe um piloto também.
bebida(Piloto, Bebida):-
squadron(SA),
member(aircraft(Piloto,_,_,Bebida,_), SA).
% @param Esporte é o parametro de busca, digita-se Piloto(com p maiusculo) e o nome de um esporte.
% @retorn é retornado quem pratica tal esporte, se nimguem praticar ele retorna falso.
esporte(Piloto, Esporte):-
squadron(SA),
member(aircraft(Piloto,_,_, _,Esporte), SA).
% @param Uma caracteristicado avião (pode ser uma cor, problema bebida ou esporte
% ) é o parametro de busca.
% @retorn é retornado o piloto que possui essa caracteristica, retorna falso
% se ninguem possuir.

nomepiloto(Piloto, X):-
squadron(SA),
member(aircraft(Piloto,Cor,Problema, Bebida, Esporte), SA), (
Cor = X;
Problema=X;
Bebida = X;
Esporte = X).
% @param Piloto é o parametro de busca.
% @retorn é retornado se o piloto pratica natacao
praticanatacao(Piloto):-
squadron(SA),
member(aircraft(Piloto,_,_, _,natacao), SA).
% @param Piloto é o nome do piloto passado como parametro de busca.
% @retorn é retornado se o piloto possui problema na bussola
problemanabussola(Piloto):-
squadron(SA),
member(aircraft(Piloto,_,bussola, _, _), SA).

% rules
% 1 O avião do Cel. Milton solta fumaça vermelha.
% 2 O rádio transmissor do Ten. Walter está com problemas.
% 3 O piloto do avião que solta fumaça verde adora pescar.
% 4 O Major Rui joga futebol nos finais de semana.
% 5 O avião que solta fumaça verde está imediatamente à direita do avião que solta fumaça branca.
% 6 O piloto que bebe leite está com o altímetro desregulado.
% 7 O piloto do avião que solta fumaça preta bebe cerveja.
% 8 O praticante de natação pilota o avião que solta fumaça vermelha.
% 9 O Cap. Farfarelli está na ponta esquerda da formação.
% 10 O piloto que bebe café voa ao lado do avião que está com pane no sistema hidráulico.
% 11 O piloto que bebe cerveja voa ao lado do piloto que enfrenta problemas na bússola.
% 12 O homem que pratica equitação gosta de beber chá.
% 13 O Cap. Nascimento bebe somente água.
% 14 O Cap. Farfarelli voa ao lado do avião que solta fumaça azul.
% 15 Na formação, há um avião entre o que tem problema hidráulico e o com pane no altímetro.

% Squadron of aircraft
% regra para dizer que a esta ao lado de b, ou seja é seu vizinho
% caso "a" for encontrado antes e/ou depois de "b", "ab" é onde os dois se encontram
neighbor(A, B, AB) :- append(_, [A,B|_], AB), A\=B.
neighbor(A, B, AB) :- append(_, [B,A|_], AB), A\=B.
rightside(A, B, AB) :- append(_, [A,B|_], AB), A\=B.
% se a e b possuirem um vizinho em comum há apenas um avião entre eles,
% pois neste problema não há dois aviões iguais
onebetween(A, B, AB) :- neighbor(X, A, AB), neighbor(X, B, AB), A \=B.
% cada avião ou seu piloto esta representado como:
% aircraft(piloto, cor, anomalia, bebida, esporte).
% a esquadrilha-de-avioes é composta de 5 aviões por isso length(SA, 5)
squadron(SA) :-

%os numeros se referem às dicas expostas anteriormente.
length(SA, 5),
member(aircraft(milton, vermelha, _, _, _), SA),%1
member(aircraft(walter, _, radio, _, _), SA),%2
member(aircraft(_, verde, _, _, pesca), SA),%3
member(aircraft(rui, _, _, _, futebol), SA),%4
rightside(aircraft(_,branca,_,_,_), aircraft(_,verde,_,_,_), SA), % 5
member(aircraft(_, _,altimetro, leite, _), SA), %6
member(aircraft(_, preta, _, cerveja, _),SA), %7
member(aircraft(_, vermelha, _, _, natacao),SA),%8
SA= [aircraft(farfarelli,_,_,_,_)| _],%9
neighbor(aircraft(_,_,_,cafe,_), aircraft(_,_,hidraulico,_,_), SA),%10
neighbor(aircraft(_,_,_,cerveja,_), aircraft(_,_,bussola,_,_), SA),%11
member(aircraft(_,_,_,cha, equitacao), SA),%12
member(aircraft(nascimento, _, _, agua, _), SA),%13
neighbor(aircraft(farfarelli,_,_,_,_), aircraft(_,azul,_,_,_), SA),%14
onebetween(aircraft(_,_,hidraulico,_,_), aircraft(_,_, altimetro,_,_), SA), %15
% os valores possiveis estão a seguir listados.
% é definido no prolog que algum membro da lista possui tal atributo

%pilotos
member(aircraft(farfarelli, _, _, _, _), SA),
member(aircraft(milton, _, _, _, _), SA),
member(aircraft(nascimento, _, _, _, _), SA),
member(aircraft(rui, _, _, _, _), SA),
member(aircraft(walter, _, _, _, _), SA),

%cores
member(aircraft(_, azul, _, _, _), SA),
member(aircraft(_, branca, _, _, _), SA),
member(aircraft(_, verde, _, _, _), SA),
member(aircraft(_, vermelha, _, _, _), SA),
member(aircraft(_, preta, _, _, _), SA),

%defeitos
member(aircraft(_,_, altimetro, _, _), SA),
member(aircraft(_,_, bussola, _, _), SA),
member(aircraft(_,_, hidraulico, _, _), SA),
member(aircraft(_,_, radio, _, _), SA),
member(aircraft(_,_, temperatura, _, _), SA),

%bebidas
member(aircraft(_,_, _, agua, _), SA),
member(aircraft(_,_, _, cafe, _), SA),
member(aircraft(_,_, _, cha, _), SA),
member(aircraft(_,_, _, cerveja, _), SA),
member(aircraft(_,_, _, leite, _), SA),

%esportes
member(aircraft(_,_, _, _, equitacao), SA),
member(aircraft(_,_, _, _, futebol), SA),
member(aircraft(_,_, _, _, natacao), SA),
member(aircraft(_,_, _, _, pesca), SA),
member(aircraft(_,_, _, _, tenis), SA).

% consultas
%
% ?- squadron(X).
% X = [
% aircraft(farfarelli, preta, hidraulico, cerveja, tenis),
% aircraft(rui, azul, bussola, cafe, futebol),
% aircraft(milton, vermelha, altimetro, leite, natacao),
% aircraft(walter, branca, radio, cha, equitacao),
% aircraft(nascimento, verde, temperatura, agua, pesca)
% ] .
%
% ?- bebida(Quem, agua).
% Quem = nascimento .
%
% ?- esporte(piloto, natacao).
% false.
%
% ?- esporte(Piloto, natacao).
% Piloto = milton .
%
% ?- nomepiloto(Piloto, vermelha).
% Piloto = milton .
%
% ?- praticanatacao(milton).
% true .
%
% ?- praticanatacao(rui).
% false.
%
% ?- problemanabussola(rui).
% true
