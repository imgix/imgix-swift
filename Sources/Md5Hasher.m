//
//  Md5Hasher.m
//  imgix-swift
//
//  Created by Paul Straw on 7/5/16.
//
//

#import "Md5Hasher.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation Md5Hasher

+ (NSString *)hash:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

    void *digestBuffer = malloc(CC_MD5_DIGEST_LENGTH);
    CC_MD5(data.bytes, (CC_LONG)data.length, digestBuffer);
    NSData *digest = [NSData dataWithBytesNoCopy:digestBuffer length:CC_MD5_DIGEST_LENGTH];

    NSMutableString *builder = [[NSMutableString alloc] init];
    const unsigned char *buffer = digest.bytes;
    for (NSUInteger i = 0; i < digest.length; i++) {
        [builder appendFormat:@"%02x", buffer[i]];
    }
    return builder;
}

@end
