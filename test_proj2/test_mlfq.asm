
_test_mlfq:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// Number of level(priority) of MLFQ scheduler
#define MLFQ_LEVEL      3

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 20             	sub    $0x20,%esp
  12:	89 c8                	mov    %ecx,%eax
    uint i;
    int cnt_level[MLFQ_LEVEL] = {0, 0, 0};
  14:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  1b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  22:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    int do_yield;
    int curr_mlfq_level;

    if (argc < 2) {
  29:	83 38 01             	cmpl   $0x1,(%eax)
  2c:	7f 17                	jg     45 <main+0x45>
        printf(1, "usage: sched_test_mlfq do_yield_or_not(0|1)\n");
  2e:	83 ec 08             	sub    $0x8,%esp
  31:	68 e8 08 00 00       	push   $0x8e8
  36:	6a 01                	push   $0x1
  38:	e8 dd 04 00 00       	call   51a <printf>
  3d:	83 c4 10             	add    $0x10,%esp
        exit();
  40:	e8 35 03 00 00       	call   37a <exit>
    }

    do_yield = atoi(argv[1]);
  45:	8b 40 04             	mov    0x4(%eax),%eax
  48:	83 c0 04             	add    $0x4,%eax
  4b:	8b 00                	mov    (%eax),%eax
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	50                   	push   %eax
  51:	e8 92 02 00 00       	call   2e8 <atoi>
  56:	83 c4 10             	add    $0x10,%esp
  59:	89 45 f0             	mov    %eax,-0x10(%ebp)

    i = 0;
  5c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        i++;
  63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        // Prevent code optimization
        __sync_synchronize();
  67:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

        if (i % YIELD_PERIOD == 0) {
  6c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  6f:	ba 59 17 b7 d1       	mov    $0xd1b71759,%edx
  74:	89 c8                	mov    %ecx,%eax
  76:	f7 e2                	mul    %edx
  78:	89 d0                	mov    %edx,%eax
  7a:	c1 e8 0d             	shr    $0xd,%eax
  7d:	69 c0 10 27 00 00    	imul   $0x2710,%eax,%eax
  83:	29 c1                	sub    %eax,%ecx
  85:	89 c8                	mov    %ecx,%eax
  87:	85 c0                	test   %eax,%eax
  89:	75 d8                	jne    63 <main+0x63>
            // Get current MLFQ level(priority) of this process
            curr_mlfq_level = getlev();
  8b:	e8 9a 03 00 00       	call   42a <getlev>
  90:	89 45 ec             	mov    %eax,-0x14(%ebp)
            cnt_level[curr_mlfq_level]++;
  93:	8b 45 ec             	mov    -0x14(%ebp),%eax
  96:	8b 44 85 e0          	mov    -0x20(%ebp,%eax,4),%eax
  9a:	8d 50 01             	lea    0x1(%eax),%edx
  9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  a0:	89 54 85 e0          	mov    %edx,-0x20(%ebp,%eax,4)

            if (i > LIFETIME) {
  a4:	81 7d f4 00 c2 eb 0b 	cmpl   $0xbebc200,-0xc(%ebp)
  ab:	76 4b                	jbe    f8 <main+0xf8>
                printf(1, "MLFQ(%s), lev[0]: %d, lev[1]: %d, lev[2]: %d\n",
  ad:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  ba:	75 07                	jne    c3 <main+0xc3>
  bc:	bb 15 09 00 00       	mov    $0x915,%ebx
  c1:	eb 05                	jmp    c8 <main+0xc8>
  c3:	bb 1d 09 00 00       	mov    $0x91d,%ebx
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	51                   	push   %ecx
  cc:	52                   	push   %edx
  cd:	50                   	push   %eax
  ce:	53                   	push   %ebx
  cf:	68 24 09 00 00       	push   $0x924
  d4:	6a 01                	push   $0x1
  d6:	e8 3f 04 00 00       	call   51a <printf>
  db:	83 c4 20             	add    $0x20,%esp
                        do_yield==0 ? "compute" : "yield",
                        cnt_level[0], cnt_level[1], cnt_level[2]);
               if(do_yield){
  de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  e2:	74 28                	je     10c <main+0x10c>
                printf(1, "yield man kkkk\n");
  e4:	83 ec 08             	sub    $0x8,%esp
  e7:	68 52 09 00 00       	push   $0x952
  ec:	6a 01                	push   $0x1
  ee:	e8 27 04 00 00       	call   51a <printf>
  f3:	83 c4 10             	add    $0x10,%esp
               }
                break;
  f6:	eb 14                	jmp    10c <main+0x10c>
            }

            if (do_yield) {
  f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  fc:	0f 84 61 ff ff ff    	je     63 <main+0x63>
                // Yield process itself, not by timer interrupt
                yield();
 102:	e8 1b 03 00 00       	call   422 <yield>
            }
        }
    }
 107:	e9 57 ff ff ff       	jmp    63 <main+0x63>
                        do_yield==0 ? "compute" : "yield",
                        cnt_level[0], cnt_level[1], cnt_level[2]);
               if(do_yield){
                printf(1, "yield man kkkk\n");
               }
                break;
 10c:	90                   	nop
                yield();
            }
        }
    }

    exit();
 10d:	e8 68 02 00 00       	call   37a <exit>

00000112 <stosb>:
 112:	55                   	push   %ebp
 113:	89 e5                	mov    %esp,%ebp
 115:	57                   	push   %edi
 116:	53                   	push   %ebx
 117:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11a:	8b 55 10             	mov    0x10(%ebp),%edx
 11d:	8b 45 0c             	mov    0xc(%ebp),%eax
 120:	89 cb                	mov    %ecx,%ebx
 122:	89 df                	mov    %ebx,%edi
 124:	89 d1                	mov    %edx,%ecx
 126:	fc                   	cld    
 127:	f3 aa                	rep stos %al,%es:(%edi)
 129:	89 ca                	mov    %ecx,%edx
 12b:	89 fb                	mov    %edi,%ebx
 12d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 130:	89 55 10             	mov    %edx,0x10(%ebp)
 133:	5b                   	pop    %ebx
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    

00000137 <strcpy>:
 137:	55                   	push   %ebp
 138:	89 e5                	mov    %esp,%ebp
 13a:	83 ec 10             	sub    $0x10,%esp
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	89 45 fc             	mov    %eax,-0x4(%ebp)
 143:	90                   	nop
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8d 50 01             	lea    0x1(%eax),%edx
 14a:	89 55 08             	mov    %edx,0x8(%ebp)
 14d:	8b 55 0c             	mov    0xc(%ebp),%edx
 150:	8d 4a 01             	lea    0x1(%edx),%ecx
 153:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 156:	0f b6 12             	movzbl (%edx),%edx
 159:	88 10                	mov    %dl,(%eax)
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	84 c0                	test   %al,%al
 160:	75 e2                	jne    144 <strcpy+0xd>
 162:	8b 45 fc             	mov    -0x4(%ebp),%eax
 165:	c9                   	leave  
 166:	c3                   	ret    

00000167 <strcmp>:
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	eb 08                	jmp    174 <strcmp+0xd>
 16c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 170:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	84 c0                	test   %al,%al
 17c:	74 10                	je     18e <strcmp+0x27>
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	0f b6 10             	movzbl (%eax),%edx
 184:	8b 45 0c             	mov    0xc(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	38 c2                	cmp    %al,%dl
 18c:	74 de                	je     16c <strcmp+0x5>
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	0f b6 00             	movzbl (%eax),%eax
 194:	0f b6 d0             	movzbl %al,%edx
 197:	8b 45 0c             	mov    0xc(%ebp),%eax
 19a:	0f b6 00             	movzbl (%eax),%eax
 19d:	0f b6 c0             	movzbl %al,%eax
 1a0:	29 c2                	sub    %eax,%edx
 1a2:	89 d0                	mov    %edx,%eax
 1a4:	5d                   	pop    %ebp
 1a5:	c3                   	ret    

000001a6 <strlen>:
 1a6:	55                   	push   %ebp
 1a7:	89 e5                	mov    %esp,%ebp
 1a9:	83 ec 10             	sub    $0x10,%esp
 1ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b3:	eb 04                	jmp    1b9 <strlen+0x13>
 1b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
 1bf:	01 d0                	add    %edx,%eax
 1c1:	0f b6 00             	movzbl (%eax),%eax
 1c4:	84 c0                	test   %al,%al
 1c6:	75 ed                	jne    1b5 <strlen+0xf>
 1c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1cb:	c9                   	leave  
 1cc:	c3                   	ret    

000001cd <memset>:
 1cd:	55                   	push   %ebp
 1ce:	89 e5                	mov    %esp,%ebp
 1d0:	83 ec 0c             	sub    $0xc,%esp
 1d3:	8b 45 10             	mov    0x10(%ebp),%eax
 1d6:	89 44 24 08          	mov    %eax,0x8(%esp)
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	89 04 24             	mov    %eax,(%esp)
 1e7:	e8 26 ff ff ff       	call   112 <stosb>
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	c9                   	leave  
 1f0:	c3                   	ret    

000001f1 <strchr>:
 1f1:	55                   	push   %ebp
 1f2:	89 e5                	mov    %esp,%ebp
 1f4:	83 ec 04             	sub    $0x4,%esp
 1f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fa:	88 45 fc             	mov    %al,-0x4(%ebp)
 1fd:	eb 14                	jmp    213 <strchr+0x22>
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
 202:	0f b6 00             	movzbl (%eax),%eax
 205:	3a 45 fc             	cmp    -0x4(%ebp),%al
 208:	75 05                	jne    20f <strchr+0x1e>
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	eb 13                	jmp    222 <strchr+0x31>
 20f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 00             	movzbl (%eax),%eax
 219:	84 c0                	test   %al,%al
 21b:	75 e2                	jne    1ff <strchr+0xe>
 21d:	b8 00 00 00 00       	mov    $0x0,%eax
 222:	c9                   	leave  
 223:	c3                   	ret    

00000224 <gets>:
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	83 ec 28             	sub    $0x28,%esp
 22a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 231:	eb 4c                	jmp    27f <gets+0x5b>
 233:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 23a:	00 
 23b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23e:	89 44 24 04          	mov    %eax,0x4(%esp)
 242:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 249:	e8 44 01 00 00       	call   392 <read>
 24e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 251:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 255:	7f 02                	jg     259 <gets+0x35>
 257:	eb 31                	jmp    28a <gets+0x66>
 259:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25c:	8d 50 01             	lea    0x1(%eax),%edx
 25f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 262:	89 c2                	mov    %eax,%edx
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	01 c2                	add    %eax,%edx
 269:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26d:	88 02                	mov    %al,(%edx)
 26f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 273:	3c 0a                	cmp    $0xa,%al
 275:	74 13                	je     28a <gets+0x66>
 277:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27b:	3c 0d                	cmp    $0xd,%al
 27d:	74 0b                	je     28a <gets+0x66>
 27f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 282:	83 c0 01             	add    $0x1,%eax
 285:	3b 45 0c             	cmp    0xc(%ebp),%eax
 288:	7c a9                	jl     233 <gets+0xf>
 28a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
 290:	01 d0                	add    %edx,%eax
 292:	c6 00 00             	movb   $0x0,(%eax)
 295:	8b 45 08             	mov    0x8(%ebp),%eax
 298:	c9                   	leave  
 299:	c3                   	ret    

0000029a <stat>:
 29a:	55                   	push   %ebp
 29b:	89 e5                	mov    %esp,%ebp
 29d:	83 ec 28             	sub    $0x28,%esp
 2a0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a7:	00 
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 04 24             	mov    %eax,(%esp)
 2ae:	e8 07 01 00 00       	call   3ba <open>
 2b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 2b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2ba:	79 07                	jns    2c3 <stat+0x29>
 2bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c1:	eb 23                	jmp    2e6 <stat+0x4c>
 2c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2cd:	89 04 24             	mov    %eax,(%esp)
 2d0:	e8 fd 00 00 00       	call   3d2 <fstat>
 2d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2db:	89 04 24             	mov    %eax,(%esp)
 2de:	e8 bf 00 00 00       	call   3a2 <close>
 2e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2e6:	c9                   	leave  
 2e7:	c3                   	ret    

000002e8 <atoi>:
 2e8:	55                   	push   %ebp
 2e9:	89 e5                	mov    %esp,%ebp
 2eb:	83 ec 10             	sub    $0x10,%esp
 2ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2f5:	eb 25                	jmp    31c <atoi+0x34>
 2f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2fa:	89 d0                	mov    %edx,%eax
 2fc:	c1 e0 02             	shl    $0x2,%eax
 2ff:	01 d0                	add    %edx,%eax
 301:	01 c0                	add    %eax,%eax
 303:	89 c1                	mov    %eax,%ecx
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	8d 50 01             	lea    0x1(%eax),%edx
 30b:	89 55 08             	mov    %edx,0x8(%ebp)
 30e:	0f b6 00             	movzbl (%eax),%eax
 311:	0f be c0             	movsbl %al,%eax
 314:	01 c8                	add    %ecx,%eax
 316:	83 e8 30             	sub    $0x30,%eax
 319:	89 45 fc             	mov    %eax,-0x4(%ebp)
 31c:	8b 45 08             	mov    0x8(%ebp),%eax
 31f:	0f b6 00             	movzbl (%eax),%eax
 322:	3c 2f                	cmp    $0x2f,%al
 324:	7e 0a                	jle    330 <atoi+0x48>
 326:	8b 45 08             	mov    0x8(%ebp),%eax
 329:	0f b6 00             	movzbl (%eax),%eax
 32c:	3c 39                	cmp    $0x39,%al
 32e:	7e c7                	jle    2f7 <atoi+0xf>
 330:	8b 45 fc             	mov    -0x4(%ebp),%eax
 333:	c9                   	leave  
 334:	c3                   	ret    

00000335 <memmove>:
 335:	55                   	push   %ebp
 336:	89 e5                	mov    %esp,%ebp
 338:	83 ec 10             	sub    $0x10,%esp
 33b:	8b 45 08             	mov    0x8(%ebp),%eax
 33e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 341:	8b 45 0c             	mov    0xc(%ebp),%eax
 344:	89 45 f8             	mov    %eax,-0x8(%ebp)
 347:	eb 17                	jmp    360 <memmove+0x2b>
 349:	8b 45 fc             	mov    -0x4(%ebp),%eax
 34c:	8d 50 01             	lea    0x1(%eax),%edx
 34f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 352:	8b 55 f8             	mov    -0x8(%ebp),%edx
 355:	8d 4a 01             	lea    0x1(%edx),%ecx
 358:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 35b:	0f b6 12             	movzbl (%edx),%edx
 35e:	88 10                	mov    %dl,(%eax)
 360:	8b 45 10             	mov    0x10(%ebp),%eax
 363:	8d 50 ff             	lea    -0x1(%eax),%edx
 366:	89 55 10             	mov    %edx,0x10(%ebp)
 369:	85 c0                	test   %eax,%eax
 36b:	7f dc                	jg     349 <memmove+0x14>
 36d:	8b 45 08             	mov    0x8(%ebp),%eax
 370:	c9                   	leave  
 371:	c3                   	ret    

00000372 <fork>:
 372:	b8 01 00 00 00       	mov    $0x1,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <exit>:
 37a:	b8 02 00 00 00       	mov    $0x2,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <wait>:
 382:	b8 03 00 00 00       	mov    $0x3,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <pipe>:
 38a:	b8 04 00 00 00       	mov    $0x4,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <read>:
 392:	b8 05 00 00 00       	mov    $0x5,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <write>:
 39a:	b8 10 00 00 00       	mov    $0x10,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <close>:
 3a2:	b8 15 00 00 00       	mov    $0x15,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <kill>:
 3aa:	b8 06 00 00 00       	mov    $0x6,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <exec>:
 3b2:	b8 07 00 00 00       	mov    $0x7,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <open>:
 3ba:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <mknod>:
 3c2:	b8 11 00 00 00       	mov    $0x11,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <unlink>:
 3ca:	b8 12 00 00 00       	mov    $0x12,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <fstat>:
 3d2:	b8 08 00 00 00       	mov    $0x8,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <link>:
 3da:	b8 13 00 00 00       	mov    $0x13,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <mkdir>:
 3e2:	b8 14 00 00 00       	mov    $0x14,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <chdir>:
 3ea:	b8 09 00 00 00       	mov    $0x9,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <dup>:
 3f2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <getpid>:
 3fa:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <sbrk>:
 402:	b8 0c 00 00 00       	mov    $0xc,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <sleep>:
 40a:	b8 0d 00 00 00       	mov    $0xd,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <uptime>:
 412:	b8 0e 00 00 00       	mov    $0xe,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <my_syscall>:
 41a:	b8 16 00 00 00       	mov    $0x16,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <yield>:
 422:	b8 17 00 00 00       	mov    $0x17,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <getlev>:
 42a:	b8 18 00 00 00       	mov    $0x18,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <set_cpu_share>:
 432:	b8 19 00 00 00       	mov    $0x19,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <putc>:
 43a:	55                   	push   %ebp
 43b:	89 e5                	mov    %esp,%ebp
 43d:	83 ec 18             	sub    $0x18,%esp
 440:	8b 45 0c             	mov    0xc(%ebp),%eax
 443:	88 45 f4             	mov    %al,-0xc(%ebp)
 446:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 44d:	00 
 44e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 451:	89 44 24 04          	mov    %eax,0x4(%esp)
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	89 04 24             	mov    %eax,(%esp)
 45b:	e8 3a ff ff ff       	call   39a <write>
 460:	c9                   	leave  
 461:	c3                   	ret    

00000462 <printint>:
 462:	55                   	push   %ebp
 463:	89 e5                	mov    %esp,%ebp
 465:	56                   	push   %esi
 466:	53                   	push   %ebx
 467:	83 ec 30             	sub    $0x30,%esp
 46a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 471:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 475:	74 17                	je     48e <printint+0x2c>
 477:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 47b:	79 11                	jns    48e <printint+0x2c>
 47d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 484:	8b 45 0c             	mov    0xc(%ebp),%eax
 487:	f7 d8                	neg    %eax
 489:	89 45 ec             	mov    %eax,-0x14(%ebp)
 48c:	eb 06                	jmp    494 <printint+0x32>
 48e:	8b 45 0c             	mov    0xc(%ebp),%eax
 491:	89 45 ec             	mov    %eax,-0x14(%ebp)
 494:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 49b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 49e:	8d 41 01             	lea    0x1(%ecx),%eax
 4a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4a4:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4aa:	ba 00 00 00 00       	mov    $0x0,%edx
 4af:	f7 f3                	div    %ebx
 4b1:	89 d0                	mov    %edx,%eax
 4b3:	0f b6 80 bc 0b 00 00 	movzbl 0xbbc(%eax),%eax
 4ba:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 4be:	8b 75 10             	mov    0x10(%ebp),%esi
 4c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4c4:	ba 00 00 00 00       	mov    $0x0,%edx
 4c9:	f7 f6                	div    %esi
 4cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d2:	75 c7                	jne    49b <printint+0x39>
 4d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4d8:	74 10                	je     4ea <printint+0x88>
 4da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4dd:	8d 50 01             	lea    0x1(%eax),%edx
 4e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4e3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 4e8:	eb 1f                	jmp    509 <printint+0xa7>
 4ea:	eb 1d                	jmp    509 <printint+0xa7>
 4ec:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f2:	01 d0                	add    %edx,%eax
 4f4:	0f b6 00             	movzbl (%eax),%eax
 4f7:	0f be c0             	movsbl %al,%eax
 4fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	89 04 24             	mov    %eax,(%esp)
 504:	e8 31 ff ff ff       	call   43a <putc>
 509:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 50d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 511:	79 d9                	jns    4ec <printint+0x8a>
 513:	83 c4 30             	add    $0x30,%esp
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	5d                   	pop    %ebp
 519:	c3                   	ret    

0000051a <printf>:
 51a:	55                   	push   %ebp
 51b:	89 e5                	mov    %esp,%ebp
 51d:	83 ec 38             	sub    $0x38,%esp
 520:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 527:	8d 45 0c             	lea    0xc(%ebp),%eax
 52a:	83 c0 04             	add    $0x4,%eax
 52d:	89 45 e8             	mov    %eax,-0x18(%ebp)
 530:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 537:	e9 7c 01 00 00       	jmp    6b8 <printf+0x19e>
 53c:	8b 55 0c             	mov    0xc(%ebp),%edx
 53f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 542:	01 d0                	add    %edx,%eax
 544:	0f b6 00             	movzbl (%eax),%eax
 547:	0f be c0             	movsbl %al,%eax
 54a:	25 ff 00 00 00       	and    $0xff,%eax
 54f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 552:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 556:	75 2c                	jne    584 <printf+0x6a>
 558:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 55c:	75 0c                	jne    56a <printf+0x50>
 55e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 565:	e9 4a 01 00 00       	jmp    6b4 <printf+0x19a>
 56a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56d:	0f be c0             	movsbl %al,%eax
 570:	89 44 24 04          	mov    %eax,0x4(%esp)
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	89 04 24             	mov    %eax,(%esp)
 57a:	e8 bb fe ff ff       	call   43a <putc>
 57f:	e9 30 01 00 00       	jmp    6b4 <printf+0x19a>
 584:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 588:	0f 85 26 01 00 00    	jne    6b4 <printf+0x19a>
 58e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 592:	75 2d                	jne    5c1 <printf+0xa7>
 594:	8b 45 e8             	mov    -0x18(%ebp),%eax
 597:	8b 00                	mov    (%eax),%eax
 599:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5a0:	00 
 5a1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5a8:	00 
 5a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	89 04 24             	mov    %eax,(%esp)
 5b3:	e8 aa fe ff ff       	call   462 <printint>
 5b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5bc:	e9 ec 00 00 00       	jmp    6ad <printf+0x193>
 5c1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5c5:	74 06                	je     5cd <printf+0xb3>
 5c7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5cb:	75 2d                	jne    5fa <printf+0xe0>
 5cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d0:	8b 00                	mov    (%eax),%eax
 5d2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5d9:	00 
 5da:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5e1:	00 
 5e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e6:	8b 45 08             	mov    0x8(%ebp),%eax
 5e9:	89 04 24             	mov    %eax,(%esp)
 5ec:	e8 71 fe ff ff       	call   462 <printint>
 5f1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f5:	e9 b3 00 00 00       	jmp    6ad <printf+0x193>
 5fa:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5fe:	75 45                	jne    645 <printf+0x12b>
 600:	8b 45 e8             	mov    -0x18(%ebp),%eax
 603:	8b 00                	mov    (%eax),%eax
 605:	89 45 f4             	mov    %eax,-0xc(%ebp)
 608:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 610:	75 09                	jne    61b <printf+0x101>
 612:	c7 45 f4 62 09 00 00 	movl   $0x962,-0xc(%ebp)
 619:	eb 1e                	jmp    639 <printf+0x11f>
 61b:	eb 1c                	jmp    639 <printf+0x11f>
 61d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 620:	0f b6 00             	movzbl (%eax),%eax
 623:	0f be c0             	movsbl %al,%eax
 626:	89 44 24 04          	mov    %eax,0x4(%esp)
 62a:	8b 45 08             	mov    0x8(%ebp),%eax
 62d:	89 04 24             	mov    %eax,(%esp)
 630:	e8 05 fe ff ff       	call   43a <putc>
 635:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 639:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63c:	0f b6 00             	movzbl (%eax),%eax
 63f:	84 c0                	test   %al,%al
 641:	75 da                	jne    61d <printf+0x103>
 643:	eb 68                	jmp    6ad <printf+0x193>
 645:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 649:	75 1d                	jne    668 <printf+0x14e>
 64b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64e:	8b 00                	mov    (%eax),%eax
 650:	0f be c0             	movsbl %al,%eax
 653:	89 44 24 04          	mov    %eax,0x4(%esp)
 657:	8b 45 08             	mov    0x8(%ebp),%eax
 65a:	89 04 24             	mov    %eax,(%esp)
 65d:	e8 d8 fd ff ff       	call   43a <putc>
 662:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 666:	eb 45                	jmp    6ad <printf+0x193>
 668:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 66c:	75 17                	jne    685 <printf+0x16b>
 66e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 671:	0f be c0             	movsbl %al,%eax
 674:	89 44 24 04          	mov    %eax,0x4(%esp)
 678:	8b 45 08             	mov    0x8(%ebp),%eax
 67b:	89 04 24             	mov    %eax,(%esp)
 67e:	e8 b7 fd ff ff       	call   43a <putc>
 683:	eb 28                	jmp    6ad <printf+0x193>
 685:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 68c:	00 
 68d:	8b 45 08             	mov    0x8(%ebp),%eax
 690:	89 04 24             	mov    %eax,(%esp)
 693:	e8 a2 fd ff ff       	call   43a <putc>
 698:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 69b:	0f be c0             	movsbl %al,%eax
 69e:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a2:	8b 45 08             	mov    0x8(%ebp),%eax
 6a5:	89 04 24             	mov    %eax,(%esp)
 6a8:	e8 8d fd ff ff       	call   43a <putc>
 6ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 6b4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6b8:	8b 55 0c             	mov    0xc(%ebp),%edx
 6bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6be:	01 d0                	add    %edx,%eax
 6c0:	0f b6 00             	movzbl (%eax),%eax
 6c3:	84 c0                	test   %al,%al
 6c5:	0f 85 71 fe ff ff    	jne    53c <printf+0x22>
 6cb:	c9                   	leave  
 6cc:	c3                   	ret    

000006cd <free>:
 6cd:	55                   	push   %ebp
 6ce:	89 e5                	mov    %esp,%ebp
 6d0:	83 ec 10             	sub    $0x10,%esp
 6d3:	8b 45 08             	mov    0x8(%ebp),%eax
 6d6:	83 e8 08             	sub    $0x8,%eax
 6d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
 6dc:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 6e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6e4:	eb 24                	jmp    70a <free+0x3d>
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 00                	mov    (%eax),%eax
 6eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ee:	77 12                	ja     702 <free+0x35>
 6f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f6:	77 24                	ja     71c <free+0x4f>
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	8b 00                	mov    (%eax),%eax
 6fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 700:	77 1a                	ja     71c <free+0x4f>
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	89 45 fc             	mov    %eax,-0x4(%ebp)
 70a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 710:	76 d4                	jbe    6e6 <free+0x19>
 712:	8b 45 fc             	mov    -0x4(%ebp),%eax
 715:	8b 00                	mov    (%eax),%eax
 717:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 71a:	76 ca                	jbe    6e6 <free+0x19>
 71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71f:	8b 40 04             	mov    0x4(%eax),%eax
 722:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 729:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72c:	01 c2                	add    %eax,%edx
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 00                	mov    (%eax),%eax
 733:	39 c2                	cmp    %eax,%edx
 735:	75 24                	jne    75b <free+0x8e>
 737:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73a:	8b 50 04             	mov    0x4(%eax),%edx
 73d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 740:	8b 00                	mov    (%eax),%eax
 742:	8b 40 04             	mov    0x4(%eax),%eax
 745:	01 c2                	add    %eax,%edx
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	89 50 04             	mov    %edx,0x4(%eax)
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	8b 00                	mov    (%eax),%eax
 752:	8b 10                	mov    (%eax),%edx
 754:	8b 45 f8             	mov    -0x8(%ebp),%eax
 757:	89 10                	mov    %edx,(%eax)
 759:	eb 0a                	jmp    765 <free+0x98>
 75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75e:	8b 10                	mov    (%eax),%edx
 760:	8b 45 f8             	mov    -0x8(%ebp),%eax
 763:	89 10                	mov    %edx,(%eax)
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	8b 40 04             	mov    0x4(%eax),%eax
 76b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 772:	8b 45 fc             	mov    -0x4(%ebp),%eax
 775:	01 d0                	add    %edx,%eax
 777:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 77a:	75 20                	jne    79c <free+0xcf>
 77c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77f:	8b 50 04             	mov    0x4(%eax),%edx
 782:	8b 45 f8             	mov    -0x8(%ebp),%eax
 785:	8b 40 04             	mov    0x4(%eax),%eax
 788:	01 c2                	add    %eax,%edx
 78a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78d:	89 50 04             	mov    %edx,0x4(%eax)
 790:	8b 45 f8             	mov    -0x8(%ebp),%eax
 793:	8b 10                	mov    (%eax),%edx
 795:	8b 45 fc             	mov    -0x4(%ebp),%eax
 798:	89 10                	mov    %edx,(%eax)
 79a:	eb 08                	jmp    7a4 <free+0xd7>
 79c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7a2:	89 10                	mov    %edx,(%eax)
 7a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a7:	a3 d8 0b 00 00       	mov    %eax,0xbd8
 7ac:	c9                   	leave  
 7ad:	c3                   	ret    

000007ae <morecore>:
 7ae:	55                   	push   %ebp
 7af:	89 e5                	mov    %esp,%ebp
 7b1:	83 ec 28             	sub    $0x28,%esp
 7b4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7bb:	77 07                	ja     7c4 <morecore+0x16>
 7bd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 7c4:	8b 45 08             	mov    0x8(%ebp),%eax
 7c7:	c1 e0 03             	shl    $0x3,%eax
 7ca:	89 04 24             	mov    %eax,(%esp)
 7cd:	e8 30 fc ff ff       	call   402 <sbrk>
 7d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7d9:	75 07                	jne    7e2 <morecore+0x34>
 7db:	b8 00 00 00 00       	mov    $0x0,%eax
 7e0:	eb 22                	jmp    804 <morecore+0x56>
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7eb:	8b 55 08             	mov    0x8(%ebp),%edx
 7ee:	89 50 04             	mov    %edx,0x4(%eax)
 7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f4:	83 c0 08             	add    $0x8,%eax
 7f7:	89 04 24             	mov    %eax,(%esp)
 7fa:	e8 ce fe ff ff       	call   6cd <free>
 7ff:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 804:	c9                   	leave  
 805:	c3                   	ret    

00000806 <malloc>:
 806:	55                   	push   %ebp
 807:	89 e5                	mov    %esp,%ebp
 809:	83 ec 28             	sub    $0x28,%esp
 80c:	8b 45 08             	mov    0x8(%ebp),%eax
 80f:	83 c0 07             	add    $0x7,%eax
 812:	c1 e8 03             	shr    $0x3,%eax
 815:	83 c0 01             	add    $0x1,%eax
 818:	89 45 ec             	mov    %eax,-0x14(%ebp)
 81b:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 820:	89 45 f0             	mov    %eax,-0x10(%ebp)
 823:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 827:	75 23                	jne    84c <malloc+0x46>
 829:	c7 45 f0 d0 0b 00 00 	movl   $0xbd0,-0x10(%ebp)
 830:	8b 45 f0             	mov    -0x10(%ebp),%eax
 833:	a3 d8 0b 00 00       	mov    %eax,0xbd8
 838:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 83d:	a3 d0 0b 00 00       	mov    %eax,0xbd0
 842:	c7 05 d4 0b 00 00 00 	movl   $0x0,0xbd4
 849:	00 00 00 
 84c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84f:	8b 00                	mov    (%eax),%eax
 851:	89 45 f4             	mov    %eax,-0xc(%ebp)
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	8b 40 04             	mov    0x4(%eax),%eax
 85a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 85d:	72 4d                	jb     8ac <malloc+0xa6>
 85f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 862:	8b 40 04             	mov    0x4(%eax),%eax
 865:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 868:	75 0c                	jne    876 <malloc+0x70>
 86a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86d:	8b 10                	mov    (%eax),%edx
 86f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 872:	89 10                	mov    %edx,(%eax)
 874:	eb 26                	jmp    89c <malloc+0x96>
 876:	8b 45 f4             	mov    -0xc(%ebp),%eax
 879:	8b 40 04             	mov    0x4(%eax),%eax
 87c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 87f:	89 c2                	mov    %eax,%edx
 881:	8b 45 f4             	mov    -0xc(%ebp),%eax
 884:	89 50 04             	mov    %edx,0x4(%eax)
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	8b 40 04             	mov    0x4(%eax),%eax
 88d:	c1 e0 03             	shl    $0x3,%eax
 890:	01 45 f4             	add    %eax,-0xc(%ebp)
 893:	8b 45 f4             	mov    -0xc(%ebp),%eax
 896:	8b 55 ec             	mov    -0x14(%ebp),%edx
 899:	89 50 04             	mov    %edx,0x4(%eax)
 89c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89f:	a3 d8 0b 00 00       	mov    %eax,0xbd8
 8a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a7:	83 c0 08             	add    $0x8,%eax
 8aa:	eb 38                	jmp    8e4 <malloc+0xde>
 8ac:	a1 d8 0b 00 00       	mov    0xbd8,%eax
 8b1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8b4:	75 1b                	jne    8d1 <malloc+0xcb>
 8b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8b9:	89 04 24             	mov    %eax,(%esp)
 8bc:	e8 ed fe ff ff       	call   7ae <morecore>
 8c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c8:	75 07                	jne    8d1 <malloc+0xcb>
 8ca:	b8 00 00 00 00       	mov    $0x0,%eax
 8cf:	eb 13                	jmp    8e4 <malloc+0xde>
 8d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	8b 00                	mov    (%eax),%eax
 8dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8df:	e9 70 ff ff ff       	jmp    854 <malloc+0x4e>
 8e4:	c9                   	leave  
 8e5:	c3                   	ret    
