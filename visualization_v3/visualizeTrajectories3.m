function visualizeTrajectories3(basefname,startframe,endframe, ...
    outfname,cax)
% 
% basefname - base file name of csv and nd2 files
% startframe - starting frame to visualize
% endframe - ending frame to visualize
% outfname - movie file name for output
% cax - color axis
% 
% requires BioFormats MATLAB package. Add this to the path.

% fname = [basefname, '.csv'];
% trajs = csvread(fname,1);
% trajmax = max(trajs(:,18))+1;

reader = bfGetReader([basefname '.nd2']);

figure;

trajs = csvread([basefname '.csv'],1);
selector = trajs(:,16) <= endframe & trajs(:,16) >= startframe;
trajs = trajs(selector,:);

c = summer(max(trajs(:,18))+1); % color map for display

v = VideoWriter(outfname,'MPEG-4');
v.FrameRate = 14;
v.Quality = 95;
open(v)

im1 = imagesc(bfGetPlane(reader,startframe)); colormap gray; axis off
caxis(cax)
selector = trajs(:,16)==startframe;
x = trajs(selector,1);
y = trajs(selector,2);
hold on;
trajnum = trajs(selector,18);
% scat1 = scatter(y+1,x+1,100); 
scatter(y+1,x+1,300,c(trajnum+1,:)); 

if sum(selector) > 0
    p = zeros(sum(selector),1);
    for trajnum = trajs(selector,18)' % for loops only work over row vectors in MATLAB, weirdly
        currx = trajs(trajs(:,18)==trajnum,1);
        curry = trajs(trajs(:,18)==trajnum,2);
        plot(curry+1,currx+1,'-','Color',c(trajnum+1,:)); 
    end
end

set(gcf,'Position', [680   500   560   560])
set(gcf,'InvertHardcopy','off')
set(gcf,'Color','k')

drawnow
frame = getframe(gcf);
writeVideo(v,frame);

for f = startframe+1:endframe
    
    clf;
    im1 = imagesc(bfGetPlane(reader,f+1)); colormap gray; axis off % MATLAB frame indexing here
    caxis(cax)
    selector = trajs(:,16)==f; % Python frame indexing here
    x = trajs(selector,1);
    y = trajs(selector,2);
    trajnum = trajs(selector,18);
    hold on;
    scat1 = scatter(y+1,x+1,300,c(trajnum+1,:)); 

    if sum(selector) > 0
        p = zeros(sum(selector),1);
        for trajnum = trajs(selector,18)' % for loops only work over row vectors in MATLAB, weirdly
            currx = trajs(trajs(:,18)==trajnum,1);
            curry = trajs(trajs(:,18)==trajnum,2);
            plot(curry+1,currx+1,'-','Color',c(trajnum+1,:)); 
        end
    end
    
    set(gcf,'InvertHardcopy','off')
    set(gcf,'Color','k')
    drawnow
    frame = getframe(gcf);
    writeVideo(v,frame);
end

close(v)

end