#ifndef _DES_H
#define _DES_H

int DES(unsigned char *dst, unsigned char *src, int len, const unsigned char *key);
void UNDES(unsigned char *dst, unsigned char *src, int len,const unsigned char *key);
int TDES(unsigned char *dst, unsigned char *src,int len, const unsigned char *key);
void UNTDES(unsigned char *dst, unsigned char *src,int len,  const unsigned char *key);

#endif
