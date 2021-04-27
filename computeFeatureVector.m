function v = computeFeatureVector(A)
%
% Describe an image A using a feature vector.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image. 

% Example that returns as a feature the mean intensity of the input image A
% You should modify this code in order compute the GLCM features!! Note
% that the output should be a vector with the features!! contrast,
% homogeneity, energy, etc computed at diferent angles and distances.
    if size(A,3) > 1
        A = rgb2gray(A);
    end
    v=[];
    offset = [0 1; -1 1; -1 0; -1 -1;0 -1];
    [glcm,~] =graycomatrix(A, 'offset', offset, 'Symmetric',true,'NumLevels',5);
    for i=1:length(offset)
        data = graycoprops(glcm(:,:,i));
        v(end+1) = data.Contrast;
        v(end+1) = data.Correlation;
        v(end+1) = data.Energy;
        v(end+1) = data.Homogeneity;
    end

end



