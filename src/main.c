#include "stm.h"

static void delay(volatile uint32_t count) {

    while (count--)
    {
        __asm volatile ("nop");
    }
}

int main(void)  {

    RCC_AHB1ENR |= (1U << 2);

    GPIOC_MODER &= ~(3U << 26);
    GPIOC_MODER |=  (1U << 26);

    GPIOC_OTYPER &= ~(1U << 13);
    GPIOC_OSPEEDR &= ~(3U << 26);
    GPIOC_PUPDR &= ~(3U << 26);

    while (1)   {
        GPIOC_ODR |= (1U << 13);

        delay(10000000);

        GPIOC_ODR &= ~(1U << 13);

        delay(10000000);
    }


}
