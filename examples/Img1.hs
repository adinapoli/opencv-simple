
import OpenCV

main :: IO ()
main = withWindow "cv" CvWindowAutosize $ \win -> do
    img <- imread "pictures/opencv.png" CvLoadImageColor
    imshow win img

