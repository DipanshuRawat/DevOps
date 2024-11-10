#!/bin/bash

n=$1  # Number of rows for the pyramid
pattern_type=$2  # Type of pattern (t1, t2, t3, etc.)

case $pattern_type in
    t1)
        # Pattern t1: Right-aligned pyramid
        for ((i=1; i<=n; i++))
        do
            for ((j=1; j<=n-i; j++))
            do
                echo -n " "
            done
            for ((k=1; k<=i; k++))
            do
                echo -n "* "
            done
            echo ""
        done
        ;;
    t2)
        # Pattern t2: Left-aligned pyramid
        for ((i=1; i<=n; i++))
        do
            for ((k=1; k<=i; k++))
            do
                echo -n "*"
            done
            echo ""
        done
        ;;
    t3)
        # Pattern t3: Full pyramid
        for ((i=1; i<=n; i++))
        do
            for ((j=1; j<=n-i; j++))
            do
                echo -n " "
            done
            for ((k=1; k<=2*i-1; k++))
            do
                echo -n "*"
            done
            echo ""
        done
        ;;
    t4)
        # Pattern t4: Inverted pyramid
        for ((i=1; i<=n; i++))
            do
            # Print asterisks decreasing in number for each row
            for ((j=n; j>=i; j--))
            do
                echo -n "*"
            done
            
            # Move to the next line
            echo ""
        done
        ;;
    t5)
        # Pattern t5: Right-aligned inverted pyramid
        for ((i=n; i>0; i--))
        do
            for ((j=0; j<n-i; j++))
            do
                echo -n " "
            done
            for ((k=1; k<=i; k++))
            do
                echo -n "*"
            done
            echo ""
        done
        ;;
    t6)
        # Pattern t6: Inverted full pyramid
        for ((i=n; i>0; i--))
        do
            for ((j=0; j<n-i; j++))
            do
                echo -n " "
            done
            for ((k=1; k<=2*i-1; k++))
            do
                echo -n "*"
            done
            echo ""
        done
        ;;
    t7)
        # Pattern t7: Full pyramid followed by inverted pyramid
        for ((i=1; i<=n; i++))
        do
            for ((j=1; j<=n-i; j++))
            do
                echo -n " "
            done
            for ((k=1; k<=2*i-1; k++))
            do
                echo -n "*"
            done
            echo ""
        done
        for ((i=n-1; i>0; i--))
        do
            for ((j=0; j<n-i; j++))
            do
                echo -n " "
            done
            for ((k=0; k<2*i-1; k++))
            do
                echo -n "*"
            done
            echo ""
        done
        ;;
    *)
        echo "Invalid pattern type. Use t1, t2, t3, t4, t5, t6, or t7."
        ;;
esac
