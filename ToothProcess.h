#include "Global.h"

/********************************************************************************
*
*					ɫ����⣺ColorCodeDetection�ඨ��
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

	CvScalar toothTemplateColorInit[15];//Ԥ���15�����ױ��(r,g,b)
	CvScalar toothTemplateColorCorrect[15];//��ɫУ����15�����ױ��(B,G,R)

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
	void LinearCorrection();//����У����R=a1+b1*r , G=a2+b2*g , B=a3+b3*b
	void LSF(CvPoint points[],int point_cnt,int index_power,double &kk,double &bb);//��С���˷����(y=kkx+bb)
	bool ProcessFlow();
	CvScalar* GettoothTemplateMean();
	CvScalar GetToothTemplateColor();
	CvScalar* GettoothTemplateColorCorrect();
};


/********************************************************************************
*
*					��������ɫƥ���⣺ToothSegmentation�ඨ��
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
*					�ⲿ������õĺ������ⲿ�ӿڣ�
*					by Hu yangyang 2015/11/10
*
********************************************************************************/
//ƥ������������ֵ(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)->ɫ�����ױ��(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)��ʾ���ɹ���
//Ϊ-1ʱ��ʾ���ʧ�ܣ�����������
//in Ϊapp�˽�ȡ������ͼ��
int ToothColorMatch(IplImage* in);