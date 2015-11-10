#include "ToothProcess.h"

/********************************************************************************
*
*					色卡检测：ColorCodeDetection类方法实现
*					by Hu yangyang 2015/10/26
*
********************************************************************************/
ColorCodeDetection::ColorCodeDetection(IplImage* in)
{
	inputImage = cvCloneImage(in);
	DynamicScale();

	r = cvCreateImage(cvGetSize(imageScale),8,1);
	b = cvCreateImage(cvGetSize(imageScale),8,1);
	g = cvCreateImage(cvGetSize(imageScale),8,1);
	cvSplit(imageScale,b,g,r,NULL);

	rBi = cvCreateImage(cvGetSize(imageScale),8,1);

	uchar leftMaskData[40][53] = {{0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
};
	uchar rightMaskData[40][54] = {{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0},
	{255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
};
	CvMat leftMat = cvMat(40,53,CV_8UC1,leftMaskData);
	leftMask = cvCreateImage(cvGetSize(&leftMat),8,1);
	cvConvert(&leftMat,leftMask);

	CvMat rightMat = cvMat(40,54,CV_8UC1,rightMaskData);
	rightMask = cvCreateImage(cvGetSize(&rightMat),8,1);
	cvConvert(&rightMat,rightMask);

	//预设的15个美白标尺(R,G,B)
	toothTemplateColorInit[0] = cvScalar(253,253,253);
	toothTemplateColorInit[1] = cvScalar(246,241,233);
	toothTemplateColorInit[2] = cvScalar(239,228,214);
	toothTemplateColorInit[3] = cvScalar(232,216,194);
	toothTemplateColorInit[4] = cvScalar(228,210,185);
	toothTemplateColorInit[5] = cvScalar(224,203,175);
	toothTemplateColorInit[6] = cvScalar(223,247,243);
	toothTemplateColorInit[7] = cvScalar(221,197,165);
	toothTemplateColorInit[8] = cvScalar(219,247,243);
	toothTemplateColorInit[9] = cvScalar(217,191,155);
	toothTemplateColorInit[10] = cvScalar(215,247,243);
	toothTemplateColorInit[11] = cvScalar(214,185,145);
	toothTemplateColorInit[12] = cvScalar(212,247,243);
	toothTemplateColorInit[13] = cvScalar(210,178,136);
	toothTemplateColorInit[14] = cvScalar(203,166,116);
}

ColorCodeDetection::~ColorCodeDetection()
{
	cvReleaseImage(&inputImage);
	cvReleaseImage(&imageScale);
	cvReleaseImage(&r);
	cvReleaseImage(&b);
	cvReleaseImage(&g);
	cvReleaseImage(&rBi);
	for (int i=0;i<candidateMsk.size();i++)
	{
		cvReleaseImage(&candidateMsk[i]);
	}

	cvReleaseImage(&leftMask);
	cvReleaseImage(&rightMask);

	for (int i=0;i<toothTemplate.size();i++)
	{
		cvReleaseImage(&toothTemplate[i]);
	}
}

void ColorCodeDetection::DynamicScale()
{
	int size;
	size = (inputImage->height > inputImage->width) ? inputImage->height : inputImage->width;
	
	switch (size/500)
	{
	case 0:
		imageScale = cvCloneImage(inputImage);
		break;
	case 1:
		imageScale = cvCloneImage(inputImage);
		break;
	case 2:
		imageScale = cvCreateImage(cvSize(inputImage->width/2,inputImage->height/2),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageScale);
		break;
	case 3:
		imageScale = cvCreateImage(cvSize(inputImage->width/3,inputImage->height/3),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageScale);
		break;
	case 4:
		imageScale = cvCreateImage(cvSize(inputImage->width/4,inputImage->height/4),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageScale);
		break;
	case 5:
		imageScale = cvCreateImage(cvSize(inputImage->width/5,inputImage->height/5),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageScale);
		break;
	case 6:
		imageScale = cvCreateImage(cvSize(inputImage->width/6,inputImage->height/6),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageScale);
		break;
	default:
		imageScale = cvCloneImage(inputImage);
		break;
	}
}

bool ColorCodeDetection::ProcessFlow()
{
	//Binary();
	bool flagDetect /*= CodeMaskDetectRough()*/;

	//循环检测色标
	const int T = 100;
	for (int i=0;i<20;i++)
	{
		candidateMskRect.clear();
		for (int i=0;i<candidateMsk.size();i++)
		{
			cvReleaseImage(&candidateMsk[i]);
		}
		candidateMsk.clear();
		Binary(T+i*5);
		//cvShowImage("rBi",rBi);
		//cvWaitKey(0);
		flagDetect = CodeMaskDetectRough();
		if (flagDetect)
		{
			break;
		}

		candidateMskRect.clear();
		for (int i=0;i<candidateMsk.size();i++)
		{
			cvReleaseImage(&candidateMsk[i]);
		}
		candidateMsk.clear();
		Binary(T-i*5);
		//cvShowImage("rBi",rBi);
		//cvWaitKey(0);
		flagDetect = CodeMaskDetectRough();
		if (flagDetect)
		{
			break;
		}

	}

	if (flagDetect)
	{
		CodeMaskMatchHu();
		if (ImageRegistration())
		{
			candidateMskRect.clear();
			for (int i=0;i<candidateMsk.size();i++)
			{
				cvReleaseImage(&candidateMsk[i]);
			}
			candidateMsk.clear();
			candidateMskMatchResult.clear();
			bool flagDetect2 = CodeMaskDetectRough();
			if (flagDetect2)
			{
				CodeMaskMatchHu();
			}
			else
			{
				return flagDetect2;
			}
		}
		ToothTemplateDetect();
		CalculateToothTemplateMean();
		LinearCorrection();//色标颜色校正
		return flagDetect;
	}
	else
	{
		return flagDetect;
	}
}

void ColorCodeDetection::Binary(int T)
{
	cvThreshold(r, rBi, /*100*/T, 255, CV_THRESH_BINARY_INV/*| CV_THRESH_OTSU*/);
	cvErode(rBi,rBi,NULL,1);
}

bool ColorCodeDetection::CodeMaskDetectRough()
{
	bool flag_Mask;
	IplImage* rBiCpy = cvCloneImage(rBi);
	CvSeq *pContour = NULL; 
	CvMemStorage *pStorage = cvCreateMemStorage(0); 
	int n=cvFindContours(rBiCpy,pStorage,&pContour,sizeof(CvContour),CV_RETR_CCOMP,CV_CHAIN_APPROX_SIMPLE);
	int nMask = 0;

	for(;pContour!=NULL;pContour=pContour->h_next)
	{
		int area=(int)cvContourArea(pContour);
		CvRect rect=cvBoundingRect(pContour);
		double ratio_WH = 0;
		double ratio_FILL = 0;
		double ratio_AREA  = 0;
		ratio_WH = ((double)(rect.width))/((double)(rect.height));
		ratio_FILL = ((double)area)/((double)(rect.width*rect.height));
		ratio_AREA = ((double)area)/((double)(rBiCpy->width*rBiCpy->height));
		if ((ratio_WH>=1)&&(ratio_WH<=2)&&(ratio_FILL>=0.7)&&(ratio_FILL<=1)&&(ratio_AREA<=1.0/6.0)&&(area>=200))
		{
			candidateMskRect.push_back(rect);
			
			cvSetImageROI(rBi,rect);
			IplImage* imageROI  = cvCreateImage(cvGetSize(rBi),8,1);
			cvCopy(rBi,imageROI);
			cvResetImageROI(rBi);
			candidateMsk.push_back(imageROI);

			nMask++;
		}
	}
	if (nMask >= 2)
	{
		flag_Mask = true;
	}
	else
	{
		flag_Mask = false;
	}
	//释放内存
	cvReleaseMemStorage(&pStorage);
	cvReleaseImage(&rBiCpy);
	return flag_Mask;
}

void ColorCodeDetection::CodeMaskMatchHu()
{
	for (int i=0;i<candidateMsk.size();i++)
	{
		
		double leftmatch = cvMatchShapes(leftMask,candidateMsk[i],CV_CONTOURS_MATCH_I1);
		double rightmatch = cvMatchShapes(rightMask,candidateMsk[i],CV_CONTOURS_MATCH_I1);
		if (leftmatch>rightmatch)
		{
			candidateMskMatchResult.push_back(rightmatch);
		}
		else
		{
			candidateMskMatchResult.push_back(leftmatch);
		}
	}

	
	double firstMinMatchResult = candidateMskMatchResult[0];
	double secondMinMatchResult = candidateMskMatchResult[1];
	int firstMinIndex = 0;
	int secondMinIndex = 1;
	for (int i=1;i<candidateMskMatchResult.size();i++)
	{
		if (firstMinMatchResult>candidateMskMatchResult[i])
		{
			secondMinIndex =  firstMinIndex;
			secondMinMatchResult = firstMinMatchResult;

			firstMinMatchResult = candidateMskMatchResult[i];
			firstMinIndex = i;
		}
		else if(secondMinMatchResult>candidateMskMatchResult[i])
		{
			secondMinMatchResult = candidateMskMatchResult[i];
			secondMinIndex = i;
		}
	}

	
	if (candidateMskRect[firstMinIndex].x>candidateMskRect[secondMinIndex].x)
	{
		detectLeftRect = candidateMskRect[secondMinIndex];
		detectLeftMask = candidateMsk[secondMinIndex];

		detectRightRect = candidateMskRect[firstMinIndex];
		detectRightMask = candidateMsk[firstMinIndex];
	}
	else
	{
		detectLeftRect = candidateMskRect[firstMinIndex];
		detectLeftMask = candidateMsk[firstMinIndex];

		detectRightRect = candidateMskRect[secondMinIndex];
		detectRightMask = candidateMsk[secondMinIndex];
	}
}

bool ColorCodeDetection::ImageRegistration()
{
	bool flag;
	CvPoint centerLeft,centerRight;
	centerLeft.x = detectLeftRect.x + detectLeftRect.width/2.0;
	centerLeft.y = detectLeftRect.y + detectLeftRect.height/2.0;

	centerRight.x = detectRightRect.x + detectRightRect.width/2.0;
	centerRight.y = detectRightRect.y + detectRightRect.height/2.0;
	double line_K = (double(centerRight.y-centerLeft.y))/(double(centerRight.x-centerLeft.x));
	double angle = atan(line_K);
	double PI = 3.14159265;
	double rot_Angle = angle*(180.0/PI);

	if (abs(rot_Angle)>=2.0)
	{
		CvMat* rot_mat = cvCreateMat(2,3,CV_32FC1);
		CvPoint2D32f rot_Center = cvPoint2D32f(imageScale->width/2,imageScale->height/2);
		double rot_Scale = 1;
		cv2DRotationMatrix(rot_Center,rot_Angle,rot_Scale,rot_mat);
		cvWarpAffine(imageScale,imageScale,rot_mat);
		cvWarpAffine(rBi,rBi,rot_mat);
		cvThreshold(rBi, rBi, 0, 255, CV_THRESH_BINARY| CV_THRESH_OTSU);

		//释放内存
		cvReleaseMat(&rot_mat);
		flag = true;
	}
	else
	{
		flag = false;
	}

	return flag;
}

void ColorCodeDetection::ToothTemplateDetect()
{
	CvRect toothRectAll = cvRect(detectLeftRect.x+detectLeftRect.width,detectLeftRect.y,detectRightRect.x-detectLeftRect.x-detectLeftRect.width,detectLeftRect.height);
	cvSetImageROI(rBi,toothRectAll);
	IplImage* imageToothROI  = cvCreateImage(cvGetSize(rBi),8,1);
	cvCopy(rBi,imageToothROI);
	cvResetImageROI(rBi);

	cvSetImageROI(imageScale,toothRectAll);
	IplImage* imageScaleROI  = cvCreateImage(cvGetSize(imageScale),8,3);
	cvCopy(imageScale,imageScaleROI);
	cvResetImageROI(imageScale);

	CodeBoundaryDetect(imageToothROI);
	
	toothTemplateRect.push_back(cvRect(0,0,toothTemplateBoundaryX[0],imageToothROI->height));
	toothTemplateRect.push_back(cvRect(toothTemplateBoundaryX[0],0,toothTemplateBoundaryX[1]-toothTemplateBoundaryX[0],imageToothROI->height));
	toothTemplateRect.push_back(cvRect(toothTemplateBoundaryX[1],0,toothTemplateBoundaryX[2]-toothTemplateBoundaryX[1],imageToothROI->height));
	toothTemplateRect.push_back(cvRect(toothTemplateBoundaryX[2],0,imageToothROI->width-toothTemplateBoundaryX[2],imageToothROI->height));

	for (int i=0;i<4;i++)
	{
		toothTemplateRect[i].x += toothTemplateRect[i].width/6;
		toothTemplateRect[i].width = toothTemplateRect[i].width*4/6;
		toothTemplateRect[i].y += toothTemplateRect[i].height/6;
		toothTemplateRect[i].height = toothTemplateRect[i].height*4/6;
	}


	for (int i=0;i<4;i++)
	{

		cvSetImageROI(imageScaleROI,toothTemplateRect[i]);
		IplImage* toothROI  = cvCreateImage(cvGetSize(imageScaleROI),8,3);
		cvCopy(imageScaleROI,toothROI);
		cvResetImageROI(imageScaleROI);
		toothTemplate.push_back(toothROI);
	}
}

void ColorCodeDetection::CodeBoundaryDetect(IplImage* imageToothROI)
{
	vector<int>ToothBoundaryX;
	IplImage* imageToothROICpy = cvCloneImage(imageToothROI);
	CvSeq *pContour = NULL; 
	CvMemStorage *pStorage = cvCreateMemStorage(0); 
	int n=cvFindContours(imageToothROICpy,pStorage,&pContour,sizeof(CvContour),CV_RETR_CCOMP,CV_CHAIN_APPROX_SIMPLE);
	int nBoundary = 0;

	for(;pContour!=NULL;pContour=pContour->h_next)
	{
		int area=(int)cvContourArea(pContour);
		CvRect rect=cvBoundingRect(pContour);
		double ratio_HW = 0;
		ratio_HW = ((double)(rect.height))/((double)(rect.width));
		if ((ratio_HW>=3)&&(area>=imageToothROICpy->height))
		{
			ToothBoundaryX.push_back(rect.x+rect.width/2);
			nBoundary++;
		}
	}
	if (nBoundary == 3)
	{
		for (int i=0;i<3;i++)
		{
			toothTemplateBoundaryX[i] = ToothBoundaryX[i];
		}
		
		for (int i=0;i<3;i++)
		{
			for (int j=0;j<3-i-1;j++)
			{
				if (toothTemplateBoundaryX[j]>toothTemplateBoundaryX[j+1])
				{
					int temp = toothTemplateBoundaryX[j];
					toothTemplateBoundaryX[j] = toothTemplateBoundaryX[j+1];
					toothTemplateBoundaryX[j+1] = temp;
				}
			}
		}
	}
	else
	{
		int step = imageToothROI->width/4;
		toothTemplateBoundaryX[0] = step;
		toothTemplateBoundaryX[1] = 2*step;
		toothTemplateBoundaryX[2] = 3*step;
	}
	//释放内存
	cvReleaseMemStorage(&pStorage);
	cvReleaseImage(&imageToothROICpy);
}

void ColorCodeDetection::CalculateToothTemplateMean()
{
	for (int i=0;i<4;i++)
	{
		toothTemplateMean[i] = cvAvg(toothTemplate[i]);
	}
}

//线性校正：R=a1+b1*r , G=a2+b2*g , B=a3+b3*b (其中：（r,g,b）为预设的美白标尺值，(R,G,B)为实际拍摄的值)
void ColorCodeDetection::LinearCorrection()
{
	//R=a1+b1*r 的拟合
	double a1,b1;
	CvPoint pointsR[4];//(r,R)
	pointsR[0] = cvPoint(toothTemplateColorInit[0].val[0],toothTemplateMean[0].val[2]);
	pointsR[1] = cvPoint(toothTemplateColorInit[4].val[0],toothTemplateMean[1].val[2]);
	pointsR[2] = cvPoint(toothTemplateColorInit[9].val[0],toothTemplateMean[2].val[2]);
	pointsR[3] = cvPoint(toothTemplateColorInit[14].val[0],toothTemplateMean[3].val[2]);
	LSF(pointsR,4,1,b1,a1);

	//G=a2+b2*g 的拟合
	double a2,b2;
	CvPoint pointsG[4];//(g,G)
	pointsG[0] = cvPoint(toothTemplateColorInit[0].val[1],toothTemplateMean[0].val[1]);
	pointsG[1] = cvPoint(toothTemplateColorInit[4].val[1],toothTemplateMean[1].val[1]);
	pointsG[2] = cvPoint(toothTemplateColorInit[9].val[1],toothTemplateMean[2].val[1]);
	pointsG[3] = cvPoint(toothTemplateColorInit[14].val[1],toothTemplateMean[3].val[1]);
	LSF(pointsG,4,1,b2,a2);

	//B=a3+b3*b 的拟合
	double a3,b3;
	CvPoint pointsB[4];//(b,B)
	pointsB[0] = cvPoint(toothTemplateColorInit[0].val[2],toothTemplateMean[0].val[0]);
	pointsB[1] = cvPoint(toothTemplateColorInit[4].val[2],toothTemplateMean[1].val[0]);
	pointsB[2] = cvPoint(toothTemplateColorInit[9].val[2],toothTemplateMean[2].val[0]);
	pointsB[3] = cvPoint(toothTemplateColorInit[14].val[2],toothTemplateMean[3].val[0]);
	LSF(pointsB,4,1,b3,a3);

	//15个美白标尺的颜色校正(r,g,b)->(B,G,R)
	for (int i=0;i<15;i++)
	{
		if (i==0)
		{
			toothTemplateColorCorrect[i] = toothTemplateMean[0];
		}
		else if(i==4)
		{
			toothTemplateColorCorrect[i] = toothTemplateMean[1];
		}
		else if (i==9)
		{
			toothTemplateColorCorrect[i] = toothTemplateMean[2];
		}
		else if (i==14)
		{
			toothTemplateColorCorrect[i] = toothTemplateMean[3];
		}
		else
		{
			//拟合新值
			toothTemplateColorCorrect[i].val[0] = a3 + b3 * toothTemplateColorInit[i].val[2];//B
			toothTemplateColorCorrect[i].val[1] = a2 + b2 * toothTemplateColorInit[i].val[1];//G
			toothTemplateColorCorrect[i].val[2] = a1 + b1 * toothTemplateColorInit[i].val[0];//R
		}
	}
}

//最小二乘法拟合(y=kkx+bb)
void ColorCodeDetection::LSF(CvPoint points[],int point_cnt,int index_power,double &kk,double &bb) //Least Square Fit,points代表需要拟合的点集，point_cnt点数，index_power需要拟合的最高次数
{
	double x[10],y[10];
	double sumX[10],sumY[10];
	int i, j, n, index;
	n = point_cnt;//待拟合的点数
	//数组初始化
	for(int i = 0;i<10;i++)
	{
		x[i] = 0;
		y[i] = 0;
		sumX[i] = 0;
		sumY[i] = 0;
	}
	for(int ii =1;ii<=point_cnt;ii++)
	{
		x[ii] = points[ii-1].x;
		y[ii] = points[ii-1].y;
	}
	sumX[1] = sumY[1] = 0;
	for (i = 1; i <= n; i++)
	{
		sumX[1] += x[i];
		sumY[1] += y[i];
	}
	index = index_power;//需要拟合的最高次数
	i = n;
	sumX[0] = i;
	for (i = 2; i <= 2 * index; i++)
	{
		for (j = 1; j <= n; j++)
		{
			sumX[i] += pow(x[j], i);
		}
	}
	for (i = 2; i <= index + 1; i++)
	{
		for (j = 1; j <= n; j++)
		{
			sumY[i] += pow(x[j], i - 1) * y[j];
		}
	}
	double a[10][11],a0[10][11];
	double l[10];
	//数组初始化
	for(int i=0;i<10;i++)
	{
		l[i] = 0;
		for(int j=0;j<11;j++)
		{
			a[i][j] = 0;
			a0[i][j] = 0;
		}
	}
	int N,k;
	double sum;
	N = index + 1;
	for (i = 0; i <= index; i++)
	{
		k = 1;
		for (j = i; j <= index + i; j++)
			a[i+1][k++] = sumX[j];
		a[i+1][k++] = sumY[i + 1];
	}

	for (i = 1; i <= N ; i++)
	{
		for (j = 1; j <= N  + 1; j++)
		{
			a0[i][j] = a[i][j];
		}
	}

	k = 1;
	do
	{
		for (i = k + 1; i <= N ; i++)
		{
			l[i] = a0[i][k] / a0[k][k];
			for (j = 1; j <= N + 1; j++)
			{
				a[i][j] = a0[i][j] - l[i] * a0[k][j];
			}
		}
		if (k == N )
			break;
		k++;
		for (j = 1; j <= N ; j++)
		{
			for (i = 1; i <= N  + 1; i++)
				a0[j][i] = a[j][i];
		}
	} while (true);
	l[N ] = a[N][N  + 1] / a[N][N ];
	for (k = N - 1; k >= 1; k--)
	{
		sum = 0;
		for (j = k + 1; j <= N ; j++)
			sum += a[k][j] * l[j];
		l[k] = (a[k][N  + 1] - sum) / a[k][k];
	}
	/*for(int i=1;i<=N;i++)
	{
		printf("----%f\n",l[i]);
	}*/

	kk = l[N];
	bb = l[N-1];

	//return l[N];//返回拟合多项式最高幂次的系数，一次时返回的是直线斜率
}

CvScalar* ColorCodeDetection::GettoothTemplateMean()
{
	return toothTemplateMean;
}

CvScalar* ColorCodeDetection::GettoothTemplateColorCorrect()
{
	return toothTemplateColorCorrect;
}

CvScalar ColorCodeDetection::GetToothTemplateColor()
{

	CvRect leftTemplateColorRect = cvRect(detectLeftRect.x+detectLeftRect.width/3,detectLeftRect.y+detectLeftRect.height*7/6,detectLeftRect.width*2/3,detectLeftRect.height/2);
	CvRect rightTemplateColorRect = cvRect(detectRightRect.x,detectRightRect.y+detectRightRect.height*7/6,detectRightRect.width*2/3,detectRightRect.height/2);

	cvSetImageROI(imageScale,leftTemplateColorRect);
	IplImage* leftTemplateColorImage  = cvCreateImage(cvGetSize(imageScale),8,3);
	cvCopy(imageScale,leftTemplateColorImage);
	cvResetImageROI(imageScale);


	cvSetImageROI(imageScale,rightTemplateColorRect);
	IplImage* rightTemplateColorImage  = cvCreateImage(cvGetSize(imageScale),8,3);
	cvCopy(imageScale,rightTemplateColorImage);
	cvResetImageROI(imageScale);


	CvScalar avgLeft = cvAvg(leftTemplateColorImage);
	CvScalar avgright = cvAvg(rightTemplateColorImage);
	CvScalar templateColor = cvScalar((avgLeft.val[0]+avgright.val[0])/2,(avgLeft.val[1]+avgright.val[1])/2,(avgLeft.val[2]+avgright.val[2])/2);

	return templateColor;
}


/********************************************************************************
*
*					牙齿与颜色匹配检测：ToothSegmentation类方法实现
*					by Hu yangyang 2015/10/26
*
********************************************************************************/
ToothSegmentation::ToothSegmentation(IplImage* imageToothROI1,CvScalar templateColor1)
{
	inputImage = cvCloneImage(imageToothROI1);
	templateColor = templateColor1;
	DynamicScale();
}

ToothSegmentation::~ToothSegmentation()
{
	cvReleaseImage(&inputImage);
	cvReleaseImage(&imageToothROI);
	cvReleaseImage(&grayImage);
	cvReleaseImage(&biImage);
	cvReleaseImage(&tootEllipseMask);
	cvReleaseImage(&imageMouth_lab);
	cvReleaseImage(&imageClusterResult);
	cvReleaseImage(&toothMask);
	cvReleaseImage(&toothFull);
	cvReleaseImage(&toothFrontFourMask);
	cvReleaseImage(&toothFrontFour);
}

void ToothSegmentation::Initialize()
{
	cvLine(imageToothROI,cvPoint(imageToothROI->width/3,10),cvPoint(imageToothROI->width*2/3,10),templateColor,2);

	grayImage = cvCreateImage(cvGetSize(imageToothROI),imageToothROI->depth,1);
	cvCvtColor(imageToothROI,grayImage,CV_BGR2GRAY);

	biImage = cvCreateImage(cvGetSize(imageToothROI),imageToothROI->depth,1);
	cvThreshold(grayImage, biImage, 60, 255, CV_THRESH_BINARY_INV| CV_THRESH_OTSU);

	cvLine(biImage,cvPoint(biImage->width/3,10),cvPoint(biImage->width*2/3,10),CV_RGB(0,0,0),2);

	tootEllipseMask = cvCreateImage(cvGetSize(imageToothROI),imageToothROI->depth,1);
	cvZero(tootEllipseMask);
	segToothEllipse();
}

void ToothSegmentation::segToothEllipse()
{
	cvEllipse(tootEllipseMask,cvPoint(biImage->width/2,biImage->height/2),cvSize(biImage->width/2,biImage->height/2),0,0,360,CV_RGB(255,255,255),CV_FILLED);
	cvThreshold(tootEllipseMask, tootEllipseMask, 0, 255, CV_THRESH_BINARY| CV_THRESH_OTSU);
	for (int y=0;y<biImage->height;y++)
	{
		for (int x=0;x<biImage->width;x++)
		{
			if (cvGetReal2D(biImage,y,x)>200)
			{
				cvSetReal2D(tootEllipseMask,y,x,0);
			}
		}
	}
}

void ToothSegmentation::DynamicScale()
{
	int size;
	size = (inputImage->height > inputImage->width) ? inputImage->height : inputImage->width;

	switch (size/500)
	{
	case 0:
		imageToothROI = cvCloneImage(inputImage);
		break;
	case 1:
		imageToothROI = cvCloneImage(inputImage);
		break;
	case 2:
		imageToothROI = cvCreateImage(cvSize(inputImage->width/2,inputImage->height/2),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageToothROI);
		break;
	case 3:
		imageToothROI = cvCreateImage(cvSize(inputImage->width/3,inputImage->height/3),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageToothROI);
		break;
	case 4:
		imageToothROI = cvCreateImage(cvSize(inputImage->width/4,inputImage->height/4),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageToothROI);
		break;
	case 5:
		imageToothROI = cvCreateImage(cvSize(inputImage->width/5,inputImage->height/5),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageToothROI);
		break;
	case 6:
		imageToothROI = cvCreateImage(cvSize(inputImage->width/6,inputImage->height/6),inputImage->depth,inputImage->nChannels);
		cvResize(inputImage,imageToothROI);
		break;
	default:
		imageToothROI = cvCloneImage(inputImage);
		break;
	}
}

void ToothSegmentation::Segment()
{
	Initialize();

	imageMouth_lab = cvCreateImage(cvGetSize(imageToothROI),8,3);
	cvCvtColor(imageToothROI,imageMouth_lab,CV_BGR2Lab);

	imageClusterResult = cvCreateImage(cvGetSize(imageToothROI),8,3);
	ColorImageClusterByKMeans2(imageMouth_lab,tootEllipseMask,imageClusterResult,maxClusters);

	toothMask = cvCreateImage(cvGetSize(imageToothROI),8,1);
	cvZero(toothMask);
	for (int y=0;y<imageClusterResult->height;y++)
	{
		for (int x=0;x<imageClusterResult->width;x++)
		{
			if (cvGet2D(imageClusterResult,y,x).val[toothClusterLabel]==255)
			{
				cvSet2D(toothMask,y,x,CV_RGB(255,255,255));
			}
		}
	}

	cvSmooth(toothMask,toothMask,CV_MEDIAN,3);

	toothFull = cvCloneImage(imageToothROI);
	for (int y=0;y<toothMask->height;y++)
	{
		for (int x=0;x<toothMask->width;x++)
		{
			if (cvGetReal2D(toothMask,y,x)<100)
			{
				cvSet2D(toothFull,y,x,CV_RGB(255,255,255));
			}
		}
	}

	CvRect frontToothRect = ExtractToothFrontFour();
	frontToothRect.x += frontToothRect.width/3;
	frontToothRect.width = frontToothRect.width/3;

	frontToothRect.y += frontToothRect.height/5;
	frontToothRect.height = frontToothRect.height*3/10;//取上下四颗牙时*3/5，只取上两颗牙时*3/10

	cvSetImageROI(toothMask,frontToothRect);
	toothFrontFourMask = cvCreateImage(cvGetSize(toothMask),8,1);
	cvCopy(toothMask,toothFrontFourMask);
	cvResetImageROI(toothMask);


	cvSetImageROI(toothFull,frontToothRect);
	toothFrontFour = cvCreateImage(cvGetSize(toothFull),8,3);
	cvCopy(toothFull,toothFrontFour);
	cvResetImageROI(toothFull);

	ExtractToothColorFeature();
}

CvRect ToothSegmentation::ExtractToothFrontFour()
{
	CvSeq *pContour = NULL; 
	CvMemStorage *pStorage = cvCreateMemStorage(0); 
	IplImage* mask = cvCloneImage(toothMask);
	int n=cvFindContours(mask,pStorage,&pContour,sizeof(CvContour),CV_RETR_CCOMP,CV_CHAIN_APPROX_SIMPLE);
	int max_area = 0;
	CvRect frontToothRect = cvRect(0,0,0,0);
	for(;pContour!=NULL;pContour=pContour->h_next)
	{
		int area=(int)cvContourArea(pContour);
		CvRect rect=cvBoundingRect(pContour);
		if (max_area<area)
		{
			max_area = area;
			frontToothRect = rect;
		}
	}
	//释放内存
	cvReleaseMemStorage(&pStorage);
	cvReleaseImage(&mask);
	return frontToothRect;
}

void ToothSegmentation::ColorImageClusterByKMeans2(const IplImage* imageSrc,IplImage*tootEllipseMask, IplImage* imageResult,int cluster_count)
{
	CvMat* samples = NULL;
	CvMat* labels = NULL;
	int nCnts = 0;
	for (int y=0;y<tootEllipseMask->height;y++)
	{
		for (int x=0;x<tootEllipseMask->width;x++)
		{
			if (cvGetReal2D(tootEllipseMask,y,x)>200)
			{
				nCnts++;
			}
		}
	}
	samples = cvCreateMat(nCnts,1,CV_32FC2);
	labels = cvCreateMat(nCnts,1,CV_32SC1);

	int k = 0;
	for (int y=0;y<imageSrc->height;y++)
	{
		for (int x=0;x<imageSrc->width;x++)
		{
			if (cvGetReal2D(tootEllipseMask,y,x)>200)
			{
				CvScalar srcPixel;
				CvScalar samplesPixel = cvScalar(0.0);
				srcPixel = cvGet2D(imageSrc,y,x);
				samplesPixel.val[0] = srcPixel.val[1];//a
				samplesPixel.val[1] = srcPixel.val[2];//b
				cvSet2D(samples,k++,0,samplesPixel);
			}
		}
	}
	
	cvKMeans2(samples,cluster_count,labels,cvTermCriteria(CV_TERMCRIT_EPS+CV_TERMCRIT_ITER,100,1.0),1,0,0,NULL,0);
	
	int num[3] ={0};
	CvScalar color_label[maxClusters];
	color_label[0] = CV_RGB(255,0,0);
	color_label[1] = CV_RGB(0,255,0);
	color_label[2] = CV_RGB(0,0,255);
	k = 0;
	for (int y=0;y<imageSrc->height;y++)
	{
		for (int x=0;x<imageSrc->width;x++)
		{
			if (cvGetReal2D(tootEllipseMask,y,x)>200)
			{
				int cluster_id;
				cluster_id = cvGetReal2D(labels,k++,0);
				cvSet2D(imageResult,y,x,color_label[cluster_id]);
				num[cluster_id]++;
			}
			else
			{
				cvSet2D(imageResult,y,x,CV_RGB(0,0,0));
			}
		}
	}

	if (num[0]>=num[1]&&num[0]>=num[2])
	{
		toothClusterLabel = 2;
	}
	else if (num[1]>=num[0]&&num[1]>=num[2])
	{
		toothClusterLabel = 1;
	}
	else if (num[2]>=num[0]&&num[2]>=num[1])
	{
		toothClusterLabel = 0;
	}

	cvReleaseMat(&samples);
	cvReleaseMat(&labels);
}

void ToothSegmentation::ExtractToothColorFeature()
{
	IplImage* toothFrontFourGray = cvCreateImage(cvGetSize(toothFrontFour),8,1);
	cvCvtColor(toothFrontFour,toothFrontFourGray,CV_BGR2GRAY);

	float data[256] = {0};
	int total = 0;
	for (int y=0;y<toothFrontFourGray->height;y++)
	{
		for (int x=0;x<toothFrontFourGray->width;x++)
		{
			if (cvGetReal2D(toothFrontFourMask,y,x)>200)
			{
				int intensity = cvRound(cvGetReal2D(toothFrontFourGray,y,x));
				data[intensity]++;
				total++;
			}
		}
	}

	float sum_dark =0;
	double rate_dark = 0.2;
	int T_dark;
	for (int i=0;i<256;i++)
	{
		sum_dark += data[i];
		if ((sum_dark)/((double)total)>rate_dark)
		{
			T_dark = i;
			break;
		}
	}

	float sum_bright =0;
	double rate_bright = 0.05;
	int T_bright;
	for (int i=255;i>=0;i--)
	{
		sum_bright += data[i];
		if ((sum_bright)/((double)total)>rate_bright)
		{
			T_bright = i;
			break;
		}
	}

	for (int y=0;y<toothFrontFourGray->height;y++)
	{
		for (int x=0;x<toothFrontFourGray->width;x++)
		{
			if (cvGetReal2D(toothFrontFourGray,y,x)<=T_dark||cvGetReal2D(toothFrontFourGray,y,x)>=T_bright)
			{
				cvSet2D(toothFrontFour,y,x,CV_RGB(255,255,255));
				cvSetReal2D(toothFrontFourGray,y,x,255);
				cvSetReal2D(toothFrontFourMask,y,x,0);
			}
		}
	}

	toothColorFeature = cvAvg(toothFrontFour,toothFrontFourMask);

	cvReleaseImage(&toothFrontFourGray);
}


void ToothSegmentation::MatchModels(CvScalar* models)
{
	double min_dis = (models[0].val[0] - toothColorFeature.val[0])*(models[0].val[0] - toothColorFeature.val[0]) + (models[0].val[1] - toothColorFeature.val[1])*(models[0].val[1] - toothColorFeature.val[1]) + (models[0].val[2] - toothColorFeature.val[2])*(models[0].val[2] - toothColorFeature.val[2]);
	int min_index = 0;
	for (int i=0;i<15;i++)
	{
		double dis = (models[i].val[0] - toothColorFeature.val[0])*(models[i].val[0] - toothColorFeature.val[0]) + (models[i].val[1] - toothColorFeature.val[1])*(models[i].val[1] - toothColorFeature.val[1]) + (models[i].val[2] - toothColorFeature.val[2])*(models[i].val[2] - toothColorFeature.val[2]);
		if (dis<min_dis)
		{
			min_dis = dis;
			min_index = i;
		}
	}
	matchIndex = min_index;
}

int ToothSegmentation::GetMatchResult()
{
	return matchIndex;
}

/********************************************************************************
*
*					外部程序调用的函数（外部接口）
*					by Hu yangyang 2015/11/10
*
********************************************************************************/
//匹配结果索引返回值(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)->色标美白标尺(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)表示检测成功；
//为-1时表示检测失败，需重新拍照
//in 为app端截取出来的图像
int ToothColorMatch(IplImage* in)
{
	cvSetImageROI(in,cvRect(in->width/7,0,in->width*5/7,in->height));
	IplImage* inputimage = cvCreateImage(cvGetSize(in),8,3);
	cvCopy(in,inputimage);
	cvResetImageROI(in);

	//根据牙齿、色标相对比例位置提取色标ROI和牙齿ROI
	/*
	牙齿ROI：拍照框尺寸(w*h)
	色标ROI：拍照框下边界1.5倍h（w*1.5h）
	*/
	//toothRoI表示牙齿ROI
	cvSetImageROI(inputimage,cvRect(0,0,inputimage->width,inputimage->height*0.4));
	IplImage* imageToothROI1 = cvCreateImage(cvGetSize(inputimage),8,3);
	cvCopy(inputimage,imageToothROI1);
	cvResetImageROI(inputimage);

	//各边均往内缩1/10
	cvSetImageROI(imageToothROI1,cvRect(imageToothROI1->width/10,imageToothROI1->height/10,imageToothROI1->width*0.8,imageToothROI1->height*0.8));
	IplImage* imageToothROI = cvCreateImage(cvGetSize(imageToothROI1),8,3);
	cvCopy(imageToothROI1,imageToothROI);
	cvResetImageROI(imageToothROI1);

	//code表示色标ROI
	cvSetImageROI(inputimage,cvRect(0,inputimage->height*0.4,inputimage->width,inputimage->height*0.6));
	IplImage* imageCode = cvCreateImage(cvGetSize(inputimage),8,3);
	cvCopy(inputimage,imageCode);
	cvResetImageROI(inputimage);

	//show
	//cvShowImage("tooth",imageToothROI);
	//cvShowImage("code",imageCode);
	//cvSaveImage("testData\\tooth.jpg",imageToothROI);
	//cvSaveImage("testData\\code.jpg",imageCode);

	int resultIndex = -1;

	ColorCodeDetection codeDetect = ColorCodeDetection(imageCode);
	bool flag = codeDetect.ProcessFlow();

	if (flag)
	{
		CvScalar* colorFeature = codeDetect.GettoothTemplateColorCorrect();
		CvScalar templateColor = codeDetect.GetToothTemplateColor();

		//牙齿检测
		ToothSegmentation toothSeg = ToothSegmentation(imageToothROI,templateColor);
		toothSeg.Segment();

		//颜色匹配
		toothSeg.MatchModels(colorFeature);
		int matchResultIndex = toothSeg.GetMatchResult();
		resultIndex = matchResultIndex + 1;

	}
	else
	{
		resultIndex = -1;//色卡检测失败，请重新拍照检测
	}
	cvReleaseImage(&imageCode);
	cvReleaseImage(&imageToothROI);
	cvReleaseImage(&imageToothROI1);
	cvReleaseImage(&inputimage);
	return resultIndex;
}
