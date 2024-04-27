%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CENTRALIZA TREINAMENTO DAS REDES  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OBS: ==> Realizar primeiro treinamento da rede 1 e somente depois iniciar
% treinamento da rede 2

% Treino rede 1
%treino_r1();

% Treino rede 2
treino = readmatrix("dados_treino.csv");

%Erros da rede 1/ Saida Desejada da Rede 2
D = readmatrix("erros_r1.csv");  

treino_r2(treino, D);