#ifndef  STM
#define  STM

#include <stdint.h>

#define RCC_AHB1ENR   (*(volatile uint32_t *)(0x40023830))
#define GPIOC_MODER   (*(volatile uint32_t *)(0x40020800))
#define GPIOC_OTYPER  (*(volatile uint32_t *)(0x40020804))
#define GPIOC_OSPEEDR (*(volatile uint32_t *)(0x40020808))
#define GPIOC_PUPDR   (*(volatile uint32_t *)(0x4002080C))
#define GPIOC_ODR     (*(volatile uint32_t *)(0x40020814))

#endif /*  STM  */
