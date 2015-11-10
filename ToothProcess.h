#include "Global.h"

/********************************************************************************
*
*					色卡检测：ColorCodeDetection类定义
*					by Hu yangyang 2015/10/26
*
********************************************************************************/
class ColorCodeDetection
{
private:
	IplImage* inputImage;
	IplImage* imageScale;
	IplImage* r;
	IplImage* g;
	IplImage* b;
	IplImage* rBi;
	vector<CvRect>candidateMskRect;
	vector<IplImage*>candidateMsk;

	IplImage* leftMask;
	IplImage* rightMask;
	vector<double>candidateMskMatchResult;

	IplImage* detectLeftMask;
	IplImage* detectRightMask;
	CvRect detectLeftRect;
	CvRect detectRightRect;

	int toothTemplateBoundaryX[3];
	vector<CvRect>toothTemplateRect;
	vector<IplImage*> toothTemplate;

	CvScalar toothTemplateMean[4];

	CvScalar toothTemplateColorInit[15];//预设的15个美白标尺(r,g,b)
	CvScalar toothTemplateColorCorrect[15];//颜色校正的15个美白标尺(B,G,R)

public:
	ColorCodeDetection(IplImage* in);
	~ColorCodeDetection();
	void DynamicScale();
	void Binary(int T);
	bool CodeMaskDetectRough();
	void CodeMaskMatchHu();
	void ToothTemplateDetect();
	bool ImageRegistration();
	void CodeBoundaryDetect(IplImage* imageToothROI);
	void CalculateToothTemplateMean();
	void LinearCorrection();//线性校正：R=a1+b1*r , G=a2+b2*g , B=a3+b3*b
	void LSF(CvPoint points[],int point_cnt,int index_power,double &kk,double &bb);//最小二乘法拟合(y=kkx+bb)
	bool ProcessFlow();
	CvScalar* GettoothTemplateMean();
	CvScalar GetToothTemplateColor();
	CvScalar* GettoothTemplateColorCorrect();
};


/********************************************************************************
*
*					牙齿与颜色匹配检测：ToothSegmentation类定义
*					by Hu yangyang 2015/10/26
*
********************************************************************************/
class ToothSegmentation
{
private:
	const static int maxClusters = 3;
	IplImage* inputImage;
	IplImage* imageToothROI;
	IplImage* grayImage;
	IplImage* biImage;
	IplImage* tootEllipseMask;
	IplImage* imageMouth_lab;
	IplImage* imageClusterResult;
	IplImage* toothMask;
	IplImage* toothFull;
	IplImage* toothFrontFour;
	IplImage* toothFrontFourMask;

	int toothClusterLabel;

	CvScalar toothColorFeature;
	int matchIndex;

	CvScalar templateColor;

public:
	ToothSegmentation(IplImage* imageToothROI1,CvScalar templateColor1);
	~ToothSegmentation();

	void Initialize();
	void segToothEllipse();
	void DynamicScale();
	void ColorImageClusterByKMeans2(const IplImage* imageSrc,IplImage*tootEllipseMask, IplImage* imageResult,int cluster_count);
	void Segment();
	CvRect ExtractToothFrontFour();
	void ExtractToothColorFeature();
	void MatchModels(CvScalar* models);
	int GetMatchResult();
};


/********************************************************************************
*
*					外部程序调用的函数（外部接口）
*					by Hu yangyang 2015/11/10
*
********************************************************************************/
//匹配结果索引返回值(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)->色标美白标尺(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)表示检测成功；
//为-1时表示检测失败，需重新拍照
//in 为app端截取出来的图像
int ToothColorMatch(IplImage* in);