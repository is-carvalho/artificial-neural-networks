clear();
load("parametros.mat");
load("dados_val_teste.mat");
dados = dados_val_teste;

% Divisão em Validação e Teste
P = 0.50 ;
dimensoes = size(dados);
idx = randperm(dimensoes(1))  ;
validacao = dados(idx(1:round(P*dimensoes(1))),:) ; 
dimensoes = size(validacao);
classe_validacao = validacao(:,end)';
validacao = validacao(:,1:end-1);
teste = dados(idx(round(P*dimensoes(1))+1:end),:);

k = 1; H = 17; I = dimensoes(2); n = dimensoes(1); MSE = 0; 
predicoes = [];
Xs = [];

for i = 1:n
    % Calcular a entrada da camada escondida
    X = validacao(i, :)';
    net_h = Whi * X;   
    % Calcular a saida da camada escondida
    Yh = logsig(net_h);
    % Calcular a entrada da camada de saida
    net_o = Woh * Yh;
    % Calcular a saida rede neural
    Y = k *net_o;
    predicoes(i) = round(Y);
    Xs(i) = i;
end
figure;

% convertendo os valores da classe e das predições para valores
% categóricos.

cat_predicoes = {};
cat_classes = {};
for i = 1:length(predicoes)
   if(predicoes(i) == 4)
        cat_predicoes(i) = {'unacc'};
   elseif(predicoes(i) == 3)
        cat_predicoes(i) = {'acc'};
   elseif(predicoes(i) == 2)
       cat_predicoes(i) = {'good'};
   else
       cat_predicoes(i) = {'v-good'};
   end

   if(classe_validacao(i) == 4)
        cat_classes(i) = {'unacc'};
   elseif(classe_validacao(i) == 3)
       cat_classes(i) = {'acc'};
   elseif(classe_validacao(i == 2))
       cat_classes(i) = {'good'};
   else
       cat_classes(i) = {'v-good'};
   end
end 

cm = confusionchart(cat_classes,cat_predicoes);
cm.Title = 'Classificação de Automóveis usando MLP';
cm.XLabel = 'Classe prevista';
cm.YLabel = 'Classe real';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
plot(Xs,classe_validacao,'b',Xs, predicoes,'m');
title('Classe Prevista vs Classe Real')
legend('Real', 'Predição')