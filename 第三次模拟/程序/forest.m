clear;clc;close all

%%
% 加载Matlab提供的测试数据——使用1985年汽车进口量数据库，其中包含205个样本数据，25个自变量和1个因变量
load data.mat;
load active.mat;
Y = active;
X = data;
isCategorical = [zeros(15,1);ones(size(X,2)-15,1)]; % Categorical variable flag

%% 训练随机森林，TreeBagger使用内容，以及设置随机森林参数
tic
leaf = 5;
ntrees = 200;
fboot = 1;
disp('Training the tree bagger')
b = TreeBagger(ntrees, X,Y, 'Method','regression', 'oobvarimp','on', 'surrogate', 'on', 'minleaf',leaf,'FBoot',fboot);
toc

%% 使用训练好的模型进行预测
% 这里没有单独设置测试数据集合，如果进行真正的预测性能测试，使用未加入至模型训练的数据进行预测测试。
disp('Estimate Output using tree bagger')
tic
x = Y;
y = predict(b, X);
toc

% calculate the training data correlation coefficient
% 计算相关系数
cct=corrcoef(x,y);
cct=cct(2,1);

% Create a scatter Diagram
disp('Create a scatter Diagram')

% plot the 1:1 line
plot(x,x,'LineWidth',3);

hold on
scatter(x,y,'filled');
hold off
grid on

set(gca,'FontSize',18)
xlabel('Actual','FontSize',25)
ylabel('Estimated','FontSize',25)
title(['Training Dataset, R^2=' num2str(cct^2,2)],'FontSize',30)

drawnow

fn='ScatterDiagram';
fnpng=[fn,'.png'];
print('-dpng',fnpng);

%--------------------------------------------------------------------------
% Calculate the relative importance of the input variables
tic
disp('Sorting importance into descending order')
weights=b.OOBPermutedVarDeltaError;
[B,iranked] = sort(weights,'descend');
toc

%--------------------------------------------------------------------------
disp(['Plotting a horizontal bar graph of sorted labeled weights.']) 

%--------------------------------------------------------------------------
figure
%barh(weights(iranked),'g');
xlabel('重要程度');
ylabel('分子描述符编号');
%title('Relative Importance of Inputs in estimating Redshift');
hold on
barh(weights(iranked(1:20)),'b');
barh(weights(iranked(1:10)),'r');
set(gca, 'yTick', [1:20]);
%set(gca,'YTickLabel',{'MDEC-23','nHBAcc','maxHsOH','VC-5','VCH-5','minHsOH','minHBint10','WTPT-5','MDEC-33','C1SP2','BCUTc-1l','SHsOH','TopoPSA','ATSc2','LipoaffinityIndex','SHBint10','maxssO','ATSc5','minHBint5','MLFER_S'});
set(gca,'YTickLabel',{'660'   ,'640',   '477',    '80',    '71',   '358',   '357',  '725',   '662',    '57',   '40','239',   '717',    '23',   '588',   '238',   '532',    '26',   '352',   '677'})
%--------------------------------------------------------------------------
grid on 
xt = get(gca,'XTick');  

xt_spacing=unique(diff(xt));
xt_spacing=xt_spacing(1);    
yt = get(gca,'YTick');    
ylim([0.25 length(weights)+0.75]);
xl=xlim;
xlim([0 2.5*max(weights)]);

%--------------------------------------------------------------------------
% Add text labels to each bar
for ii=1:length(weights)
    text(...
        max([0 weights(iranked(ii))+0.02*max(weights)]),ii,...
        ['Column ' num2str(iranked(ii))],'Interpreter','latex','FontSize',11);
end

%--------------------------------------------------------------------------
set(gca,'FontSize',16)
set(gca,'XTick',0:2*xt_spacing:1.1*max(xl));
set(gca,'YTick',yt);
set(gca,'TickDir','out');
set(gca, 'ydir', 'reverse' )
set(gca,'LineWidth',2);   
drawnow

%--------------------------------------------------------------------------
fn='RelativeImportanceInputs';
fnpng=[fn,'.png'];
print('-dpng',fnpng);

%--------------------------------------------------------------------------
% Ploting how weights change with variable rank
disp('Ploting out of bag error versus the number of grown trees')

figure
plot(b.oobError,'LineWidth',2);
xlabel('Number of Trees','FontSize',30)
ylabel('Out of Bag Error','FontSize',30)
title('Out of Bag Error','FontSize',30)
set(gca,'FontSize',16)
set(gca,'LineWidth',2);   
grid on
drawnow
fn='EroorAsFunctionOfForestSize';
fnpng=[fn,'.png'];
print('-dpng',fnpng);


