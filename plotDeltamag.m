% uses violinplot from Bastian Bechtold

function delmagplot = plotDeltamag(bundle_deltamag, nstars)

delta_magnitudes = zeros(nstars,length(bundle_deltamag.info.filters));

for i = 1:nstars 
    delta_magnitudes(i,:) = bundle_deltamag.sample(i).delta_magnitudes;
end

fh=figure;
set(gcf,'color','w');
subplot(2,1,1)
delmagplot = violinplot(delta_magnitudes(:,[2:5 9], :), bundle_deltamag.info.filters([2:5 9]), ...
    'Width', 0.4,'ShowData', false, 'MedianMarkerSize', 12, ...
    'BoxColor', [0.1 0.1 0.1]);
ylim([-1.5 1]) 
xlabel('Filter')
ylabel('\Delta Magnitude')
set(gca,'FontWeight','Bold','LineWidth',1.5,...
        'FontName','Times','FontSize',14,...
        'Layer','top','YMinorTick','on');

subplot(2,1,2)
ecdf(delta_magnitudes(:,2));
hold on;
ecdf(delta_magnitudes(:,3));
hold on;
ecdf(delta_magnitudes(:,4));
hold on;
ecdf(delta_magnitudes(:,5));
hold on;
ecdf(delta_magnitudes(:,9));
xlim([-2.6 1])
xlabel('\Delta Magnitude')
ylabel('Cumulative Probability')
legend('B','V','R','I','Ha')
set(gca,'FontWeight','Bold','LineWidth',1.5,...
        'FontName','Times','FontSize',14,...
        'Layer','top','YMinorTick','on','XMinorTick','on');
h = get(gca,'children');
set(h(1:5),'LineWidth',1.5);


