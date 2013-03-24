
import OpenCV
import Control.Monad

main :: IO ()
main = withWindow "cv" CvWindowAutosize $ \win -> do
    img <- unsafeImread "pictures/opencv.png" CvLoadImageColor
    void (imshow win img >> waitKey 0)

