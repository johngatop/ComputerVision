function [] = plot_keypoints_subset(I, J, matches, scores, f_I, f_J, d_I, d_J, samples)
% plot_keypoints_subset
%   Takes a random subset of size = samples of all matching points
%   and plot on the image while connecting the matching pairs with lines.

% Convert image in the appropriate format 
I_raw = I;
J_raw = J;

% Grayscale -- incase that it is not
[~, ~, c] = size(I);
if c ~= 1
    I = rgb2gray(I);
end

% Single
I = single(I) ;

% We will take a subset of matches and scores
% 1) Generate 10 random numbers - indexes
[~, columns] = size(scores);
r = randi([1 columns],1,samples);

% 2) Get the subset using this indexes
% -- in this way, we can get the corresponding scores as well
sub_matches = zeros(2, samples);
sub_scores = zeros(samples);
for i = 1:samples
    sub_matches(:, i) = matches(:, r(i));
    sub_scores(i) = scores(r(i));
end

% 3) Plot on the figure of the two images
figure ; hold off;
imshow(cat(2, I_raw, J_raw) );
hold on ;

% 3.1) Get the axes
xa = f_I(1,sub_matches(1,:)) ;
xb = f_J(1,sub_matches(2,:)) + size(I,2) ;
ya = f_I(2,sub_matches(1,:)) ;
yb = f_J(2,sub_matches(2,:)) ;

% 3.2) Get the random color -- every color is a 3x1 array
random_color = zeros(3, samples);
for i=1:samples
    random_color(:, i) = abs(rand(1,3));
end

% 3.3) Generate lines between the keypoints
l = line([xa ; xb], [ya ; yb]) ;
% Make them have a random color
for i=1:samples
    set(l(i),'linewidth', 1.5, 'color', random_color(:,i)) ;
end

% 3.4) Plot 
f_J(1,:) = f_J(1,:) + size(I,2) ;

vl_plotframe(f_I(:,sub_matches(1,:))) ;
set(vl_plotframe(f_I(:,sub_matches(1,:))), 'color', 'y')
vl_plotframe(f_J(:,sub_matches(2,:))) ;
set(vl_plotframe(f_J(:,sub_matches(2,:))), 'color', 'y')

vl_plotsiftdescriptor(d_I(:,sub_matches(1,:)), f_I(:,sub_matches(1,:))) ;
set(vl_plotsiftdescriptor(d_I(:,sub_matches(1,:)), f_I(:,sub_matches(1,:))), 'color', 'y')

vl_plotsiftdescriptor(d_J(:,sub_matches(2,:)), f_J(:,sub_matches(2,:))) ;
set(vl_plotsiftdescriptor(d_J(:,sub_matches(2,:)), f_J(:,sub_matches(2,:))), 'color', 'y')
axis image off ;
end

