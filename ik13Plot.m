% calibrating colours based on Ducati et al. (2001 - ApJ, 558, 309), V-I is
% within 0.01 magnitudes across all masses for photospheric profiles. 
% + 0.346 in V-I +0.141 in R-Ha



function ik13 = ik13Plot(bundle_deltamag, nstars)

ik13 = zeros(nstars,1);

% gather the V-I values from the sample
V_I = zeros(nstars,1);
R_Ha = zeros(nstars,1);
inc = zeros(nstars,1);

for i = 1:nstars
    V_I(i) = bundle_deltamag.sample(i).magnitudes(3) - bundle_deltamag.sample(i).magnitudes(5) + 0.346;
    R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.1125;
   %  if contains(bundle_deltamag.sample(i).model,'3p5') == 1
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.1407;
   % elseif contains(bundle_deltamag.sample(i).model,'3p7') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.1259;
   % elseif contains(bundle_deltamag.sample(i).model,'4p2') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.1125;
   % elseif contains(bundle_deltamag.sample(i).model,'4p7') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.1054;
   % elseif contains(bundle_deltamag.sample(i).model,'5p5') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0947;
   % elseif contains(bundle_deltamag.sample(i).model,'6p0') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0929;
   % elseif contains(bundle_deltamag.sample(i).model,'8p0') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0820;
   % elseif contains(bundle_deltamag.sample(i).model,'9p0') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0777;
   % elseif contains(bundle_deltamag.sample(i).model,'10p0') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0755;
   % elseif contains(bundle_deltamag.sample(i).model,'12p0') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0715;
   % elseif contains(bundle_deltamag.sample(i).model,'14p0') == 1 
   %     R_Ha(i) = bundle_deltamag.sample(i).magnitudes(4) - bundle_deltamag.sample(i).magnitudes(9) +0.0671;   
   % end
   % 
    inc(i) = bundle_deltamag.sample(i).i;
end

% create threshold line
x = linspace(-0.5,1,150);
y = x.*0.1 + 0.1;

% determine whether each star falls below the threshold line and flag it in
% the output vector
below_thresh = zeros(10,1);

for j = 1:nstars
   if R_Ha(j) < 0.1*V_I(j) + 0.1
       below_thresh(inc(j)/10 + 1) = below_thresh(inc(j)/10 + 1) + 1;
       ik13(j) = 0;
   else 
       ik13(j) = 1;
   end
end

% find the fraction of stars in each inclination step that fall below the
% threshold line
frac_below_thresh = zeros(10,1);

for k = 1:length(below_thresh)
    frac_below_thresh(k) = below_thresh(k) / nnz(inc == k*10 - 10); 
end

V_Is = V_I(1:1000);
R_Has = R_Ha(1:1000);

% tiled layout
tiledlayout(2,1)

% plot R-Ha vs V-I
nexttile
set(gcf,'color','w');
scatter(V_Is, R_Has, 24,inc(1:1000),'filled', 'o')
colorbar
colormap winter
ylabel('R - H\alpha')
xlabel('V - I')
set(gca,'FontWeight','Bold','LineWidth',1.5,...
        'FontName','Times','FontSize',14,...
        'Layer','top','YMinorTick','on','XMinorTick','on');
hold on 
 
plot(x,y, 'k')

% create histogram of the fraction of stars, by inclination, that fall 
% below the cutoff line
nexttile
set(gcf,'color','w');
bar(frac_below_thresh, 'BarWidth', 1)
set(gca,'XTick', 1:10,'xticklabel',{'0','10','20','30','40','50','60','70','80','90'})
ylabel('Fraction of rejected Be stars')
xlabel('Inclination (\circ)')
set(gca,'FontWeight','Bold','LineWidth',1.5,...
        'FontName','Times','FontSize',14,...
        'Layer','top','YMinorTick','on');
