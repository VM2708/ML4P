function toPrepFilesForDBSCAN(cellID)

    if cellID == 5
        BasePath = '/Users/vedhasyamuvva/Desktop/ZLab/';
        expDate = '20251113';
        testName = '/SC35-mCherry_test1';
        cell_num = 'Stream7_GFP--nucleus_3';
    
    
        expPath = [BasePath expDate testName '/Data/Tiffs/' cell_num];
    
        GFPImagePath =  [expPath '-GFPMaskedStack.tif'];
        mCherryImagePath = [expPath '-RFPMaskedStack_fix.tif'];
    
        GFPTiff = OpenTiff(GFPImagePath);
        RFPTiff = OpenTiff(mCherryImagePath);
    
    else
        %mainpath = '/Users/vedhasyamuvva/Desktop/ZLab';
        mainpath = '/Volumes/zlab/Vedha';
        DCSfolder = [mainpath '/DCS'];
        
    
        GFPTiff = OpenTiff([DCSfolder sprintf('/Cell%d/Stream_Masked.tif', cellID)]);
        RFPTiff = OpenTiff([DCSfolder sprintf('/Cell%d/Stream_Masked.tif', cellID+16)]);
    end
    endPath = '/Users/vedhasyamuvva/Desktop/ML4P/FinalProject/data';
    if cellID <= 10
        "train"
        endPath = [endPath '/train_data'];
    elseif cellID >10 && cellID <= 13
        "valid"
        endPath = [endPath '/validation_data'];
    else
        "test"
        endPath = [endPath '/test_data'];
    end

    % Normalize full stack before per-frame extraction
    GFPNorm = normalizeIntensity01(GFPTiff);
    RFPNorm = normalizeIntensity01(RFPTiff);

    nFrames = 100;  % adjust for longer streams

    for f = 1:nFrames
        GFPFrame = squeeze(GFPNorm(:, :, f));
        RFPFrame = squeeze(RFPNorm(:, :, f));

        [nRows, nCols] = size(GFPFrame);
        [X, Y] = meshgrid(1:nCols, 1:nRows);

        x_coords = X(:);
        y_coords = Y(:);
        gfp_vals = GFPFrame(:);
        rfp_vals = RFPFrame(:);

        % Filter masked (zero) pixels
        mask = gfp_vals > 0 | rfp_vals > 0;
        features = [x_coords(mask), y_coords(mask), gfp_vals(mask), rfp_vals(mask)];

        % Save one file per cell-frame: cell_03_frame_007.mat
        filename = sprintf('cell_%02d_frame_%03d.mat', cellID, f);
        save(fullfile(endPath, filename), 'features');
    end

    fprintf('Saved cell %d: %d frames\n', cellID, nFrames);
end

for cellID = 2:13
    toPrepFilesForDBSCAN(cellID);
end

%Train is split cells 1-10
% Validate is split cells 11-13
% test is split cells 14-16
