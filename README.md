# Removing Rain from Single Images via a Deep Detail Network

You can download the [paper](http://smartdsp.xmu.edu.cn/memberpdf/fuxueyang/cvpr2017/cvpr2017.pdf) or learn the details [there](http://smartdsp.xmu.edu.cn/cvpr2017.html)

Abstract: We propose a new deep network architecture for removing rain streaks from individual images based on the deep convolutional neural network (CNN). Inspired by the deep residual network (ResNet) that simpliﬁes the learning process by changing the mapping form, we propose a deep detail network to directly reduce the mapping range from input to output, which makes the learning process easier. To further improve the de-rained result, we use a priori image domain knowledge by focusing on high frequency detail during training, which removes background interference and focuses the model on the structure of rain in images. This demonstrates that a deep architecture not only has beneﬁts for high-level vision tasks but also can be used to solve low-level imaging problems. Though we train the network on synthetic data, we ﬁnd that the learned network generalizes well to real-world test images. Experiments show that the proposed method signiﬁcantly outperforms state-of-the-art methods on both synthetic and real-world images in terms of both qualitative and quantitative measures. We discuss applications of this structure to denoising and JPEG artifact reduction at the end of the paper.
<br>
<br>
![picture](http://smartdsp.xmu.edu.cn/memberpdf/fuxueyang/cvpr2017/1.JPG)
