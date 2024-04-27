%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SCRIPT DE VALIDAÇÃO E TESTE - REDE 2 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear();
% Carregando pesos rede 2
load("pesos_rede02.mat");

% Carregando dados de validação e teste
dados = readmatrix("dados_teste.csv");
teste = dados;
classe_teste = teste(:,end)';
teste = teste(:,1:end-1);
dimensoes = size(teste);

% Inicializando parâmetros da rede 1
k = 1; H = 11; I = dimensoes(2); n = dimensoes(1);

predicoes_r2 = [];
Xs = [];

for i = 1:n
    % Calcular a entrada da camada escondida
    X = teste(i, :)';
    net_h = Whi * X;   
    % Calcular a saida da camada escondida
    Yh = logsig(net_h);
    % Calcular a entrada da camada de saida
    net_o = Woh * Yh;
    % Calcular a saida rede neural
    Y = k *net_o;
    predicoes_r2(i) = Y;
    Xs(i) = i;
end

% Salvando predicoes rede 2
writematrix(predicoes_r2, "predicoes_r2.csv");
% Carregando predicoes da rede 1
predicoes_r1 = readmatrix("predicoes_r1.csv");
% Somando predicoes da rede 1 com as predicoes da rede 2
predicoes = round(predicoes_r1 + predicoes_r2);
  
figure;
% convertendo os valores da classe e das predições para valores
% categóricos para usar na matriz de confusão.
cat_predicoes = {};
cat_classes = {};
for i = 1:length(predicoes)
   if(predicoes(i) == 6)
        cat_predicoes(i) = {'DA'};
   elseif(predicoes(i) == 5)
        cat_predicoes(i) = {'QUER'};
   elseif(predicoes(i) == 4)
       cat_predicoes(i) = {'ES'};
   elseif(predicoes(i) == 3)
       cat_predicoes(i) = {'TA'};
   elseif(predicoes(i) == 2)
       cat_predicoes(i) = {'REI'};
   else
       cat_predicoes(i) = {'DI'};
   end

   if(classe_teste(i) == 6)
        cat_classes(i) = {'DA'};
   elseif(classe_teste(i) == 5)
       cat_classes(i) = {'QUER'};
   elseif(classe_teste(i) == 4)
       cat_classes(i) = {'ES'};
   elseif(classe_teste(i) == 3)
       cat_classes(i) = {'TA'};
   elseif(classe_teste(i) == 2)
       cat_classes(i) = {'REI'};
   else
       cat_classes(i) = {'DI'};
   end
end 
% Plotando matriz de confusão
cm = confusionchart(cat_classes,cat_predicoes);
cm.Title = 'Classificação de Fonemas usando MRNA MLP';
cm.XLabel = 'Classe prevista';
cm.YLabel = 'Classe real';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';

    

