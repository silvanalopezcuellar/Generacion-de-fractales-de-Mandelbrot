#include <iostream>
#include <math.h>
#include <stdio.h>
#include <windows.h>

using namespace std;
int xn[2]={0,0}, yn[2]={0,0}, cx=0, cy=0, escape=0;
float matriz[480][480];

void xcoordenada(int cx, int xn, int yn);
void ycoordenada(int cy, int xn, int yn);

int main (){

	xn[1]= xcoordenada(cx,xn[0],yn[0]);
	yn[1]= ycoordenada(cy,xn[0],yn[0]);
	escape = pow(xn[1],2)+pow(yn[1],2);
	if(escape < 4){
		matriz[cx][cy]=1;
	else
		matriz[cx][cy]=0;
	}
	xn[0]=xn[1];
	yn[0]=yn=[1];
	for(int i=1, i<480, i++)
		cx=cx++;
		for(int j, j<480, j++)
			cy=cy++;
	}
}


void xcoordenada(int cx, int xn, int yn){
 int x=(pow(xn[0],2))-(pow(yn[0],2))+cx;
	return x;
}

void ycoordenada(int cy, int xn, int yn){
 int y=2*(pow(xn[0],2))*(pow(yn[0],2))+cy;
	return y;
}

