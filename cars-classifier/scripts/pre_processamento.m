% Script para Pré-Processamento dos dados.

dados = readtable("car.csv");
dados.Properties.VariableNames = {'buying', 'maint', 'doors', 'persons', 'lug_boot', 'safety', 'class'};

for i = 1:height(dados)
    if(strcmp(dados{i,"buying"}, 'vhigh'))
        dados{i,1} = {4};
    elseif(strcmp(dados{i,"buying"}, 'high'))
        dados{i,1} = {3};
    elseif(strcmp(dados{i,"buying"}, 'med'))
        dados{i,1} = {2};
    else
        dados{i,1} = {1};
    end

    if(strcmp(dados{i,"maint"}, 'vhigh'))
        dados{i,2} = {4};
    elseif(strcmp(dados{i,"maint"}, 'high'))
        dados{i,2} = {3};
    elseif(strcmp(dados{i,"maint"}, 'med'))
        dados{i,2} = {2};
    else
        dados{i,2} = {1};
    end
    
    if(isnan(dados{i,"doors"}))
        dados{i,3} = 5;
    end

    if(isnan(dados{i, 'persons'}))
        dados{i,4} = 5;
    end

    if(strcmp(dados{i,"lug_boot"}, 'small'))
        dados{i,5} = {1};
    elseif(strcmp(dados{i,"lug_boot"}, 'med'))
        dados{i,5} = {2};
    else
       dados{i,5} = {3};
    end

    if(strcmp(dados{i,"safety"}, 'low'))
        dados{i,6} = {1};
    elseif(strcmp(dados{i,"safety"}, 'med'))
        dados{i,6} = {2};
    else
       dados{i,6} = {3};
    end
    
    if(strcmp(dados{i,"class"}, 'unacc'))
        dados{i,7} = {4};
     elseif(strcmp(dados{i,"class"}, 'acc'))
        dados{i,7} = {3};
    elseif(strcmp(dados{i,"class"}, 'good'))
        dados{i,7} = {2};
    else
       dados{i,7} = {1};
    end
end

dados.buying = cell2mat(dados.buying);
dados.maint = cell2mat(dados.maint);
dados.lug_boot = cell2mat(dados.lug_boot);
dados.safety = cell2mat(dados.safety);
dados.class = cell2mat(dados.class);
writetable(dados, 'dados.csv');