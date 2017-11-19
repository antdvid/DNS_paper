%plot taylor microscale and transitional scale
clc
clear
close all
dname = './entrainment3d';
casename = {'d_case1', 'd_case2', 'd_case3', 'f_case1', 'f_case2', 'f_case3'};
output_name = {'d1', 'd2', 'd3', 'f1', 'f2', 'f3'};
casename = strcat(casename, '_444');
r0 = 1e-5;
data = [];
legend_handle = zeros(1, length(output_name));
decro = 'ospdh^';

for i = 1 : 6
    fname = [dname casename{i}];
    taylor = load([fname '/taylor_micro.txt']);
    trans = load([fname '/trans_scale.txt']);
    t = load([fname '/time.txt']);
    rvr0   = load([fname '/rv3.txt'])/r0^3;
    
    for j = 4 : length(t)-12
        valid_index = find(taylor(j, :) > 0 & trans(j,:)>0);
	x = mean(taylor(j,:));
	y = mean(trans(j,:));
	data = [data; x, y];
        legend_handle(i) = scatter(x, y, 40, t(j)/t(end), decro(i), 'filled', 'Markeredgecolor', 'k');
        hold on
    end
end
set(gca, 'xscale', 'log', 'yscale', 'log')
axis tight
xlabel('Taylor microscale [m]')
ylabel('Transitional scale [m]')
box on
h = colorbar;
size(legend_handle)
legend_handle
legend_info = {'D1', 'D2', 'D3', 'F1', ...
    'F2', 'F3'};
legend(legend_handle, legend_info, 'location', 'SE');
ylabel(h, 'Normalized Time [s]')
saveas(gca, ['taylor_trans.eps'], 'epsc')
