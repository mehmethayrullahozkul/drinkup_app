/* Path droplet = Path();
    droplet.moveTo(0, 0);
    size = Size(size.width * /* 0.6756 */ 0.704225, size.height * 0.98);
    droplet.lineTo(size.width, 0);
    droplet.lineTo(size.width * 0.71, size.height);
    droplet.cubicTo(size.width, size.height, size.width * 1.21,
        size.height * 0.84, size.width * 1.21, size.height * 0.65);
    droplet.cubicTo(size.width * 1.21, size.height * 0.46, size.width * 0.74,
        size.height * 0.03, size.width * 0.72, size.height * 0.01);
    droplet.cubicTo(size.width * 0.72, size.height * 0.01, size.width * 0.71, 0,
        size.width * 0.71, 0);
    droplet.cubicTo(size.width * 0.71, 0, size.width * 0.7, size.height * 0.01,
        size.width * 0.7, size.height * 0.01);
    droplet.cubicTo(size.width * 0.68, size.height * 0.03, size.width / 5,
        size.height * 0.46, size.width / 5, size.height * 0.65);
    droplet.cubicTo(size.width / 5, size.height * 0.84, size.width * 0.44,
        size.height, size.width * 0.71, size.height);
    droplet.cubicTo(size.width * 0.71, size.height, size.width * 0.71,
        size.height, size.width * 0.71, size.height);
    // Set the radius for the circular arcs
    Paint dropletbg = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(droplet, dropletbg); */


    /* Path droplet = Path();
    droplet.moveTo(0, 0);
    size = Size(size.width * /* 0.6756 */ 0.704225, size.height * 0.98);
    //droplet.lineTo(size.width, 0);
    droplet.lineTo(size.width * 0.71, size.height);
    droplet.cubicTo(
        size.width * (1 - 0.04),
        size.height,
        size.width * (1.21 - 0.04),
        size.height * 0.84,
        size.width * (1.21 - 0.06),
        size.height * 0.65);
    droplet.cubicTo(
        size.width * (1.21 - 0.06),
        size.height * 0.46,
        size.width * 0.74,
        size.height * 0.03,
        size.width * 0.72,
        size.height * 0.01);
    droplet.cubicTo(size.width * 0.72, size.height * 0.01, size.width * 0.71, 0,
        size.width * 0.71, 0);
    droplet.cubicTo(size.width * 0.71, 0, size.width * 0.7, size.height * 0.01,
        size.width * 0.7, size.height * 0.01);
    droplet.cubicTo(
        size.width * 0.68,
        size.height * 0.03,
        size.width * (0.2 + 0.04),
        size.height * 0.46,
        size.width * (0.2 + 0.07),
        size.height * 0.65);
    droplet.cubicTo(size.width * (0.2 + 0.07), size.height * 0.84,
        size.width * 0.44, size.height, size.width * 0.71, size.height);
    droplet.cubicTo(size.width * 0.71, size.height, size.width * 0.71,
        size.height, size.width * 0.71, size.height); */


 // DROPLET REVISED
 /*

 Path droplet = Path();
    size = Size(size.width, size.height * 0.98);
    droplet.moveTo(0, 0);
    droplet.lineTo(size.width * 0.5, size.height);
    droplet.cubicTo(size.width * 0.704, size.height, size.width * 0.852,
        size.height * 0.84, size.width * 0.852, size.height * 0.65);
    droplet.cubicTo(size.width * 0.852, size.height * 0.46, size.width * 0.521,
        size.height * 0.03, size.width * 0.507, size.height * 0.01);
    droplet.cubicTo(size.width * 0.507, size.height * 0.01, size.width * 0.5, 0,
        size.width * 0.5, 0);
    droplet.cubicTo(size.width * 0.5, 0, size.width * 0.492, size.height * 0.01,
        size.width * 0.492, size.height * 0.01);
    droplet.cubicTo(size.width * 0.478, size.height * 0.03, size.width * 0.140,
        size.height * 0.46, size.width * 0.140, size.height * 0.65);
    droplet.cubicTo(size.width * 0.140, size.height * 0.84, size.width * 0.309,
        size.height, size.width * 0.5, size.height);
    droplet.cubicTo(size.width * 0.5, size.height, size.width * 0.5,
        size.height, size.width * 0.5, size.height);

 */       


/**

double heightChange = ((((1.0 - scale) / 2)) * size.height);
    double widthChange = ((((1.0 - scale) / 2)) * size.width);
    Path droplet = Path();
    droplet.moveTo(size.width * 0.5, size.height );
    droplet.cubicTo(
        size.width * 0.704 ,
        size.height ,
        size.width * 0.852 ,
        size.height * 0.84 ,
        size.width * (0.852 - 0.02) ,
        size.height * 0.65 );
    droplet.cubicTo(
        size.width * (0.852 - 0.02) ,
        size.height * 0.46,
        size.width * 0.521,
        size.height * 0.03 ,
        size.width * 0.507,
        size.height * 0.01 );
    droplet.cubicTo(
        size.width * 0.507,
        size.height * 0.01 ,
        size.width * 0.5,
        0 ,
        size.width * 0.493,
        0.01 );
    droplet.cubicTo(
        size.width * 0.493,
        0 ,
        size.width * 0.508,
        size.height * 0.01 ,
        size.width * 0.5,
        size.height * 0.01 );

    droplet.moveTo(size.width * 0.5, size.height ); // first half
    droplet.cubicTo(
        size.width * 0.296 ,
        size.height ,
        size.width * 0.148 ,
        size.height * 0.84 ,
        size.width * (0.148 + 0.02) ,
        size.height * 0.65 );
    droplet.cubicTo(
        size.width * (0.148 + 0.02) ,
        size.height * 0.46,
        size.width * 0.479,
        size.height * 0.03 ,
        size.width * 0.493,
        size.height * 0.01 );
    droplet.cubicTo(
        size.width * 0.493,
        size.height * 0.01 ,
        size.width * 0.5,
        0 ,
        size.width * 0.507,
        0.01 );
    droplet.cubicTo(
        size.width * 0.507,
        0 ,
        size.width * 0.492,
        size.height * 0.01 ,
        size.width * 0.5,
        size.height * 0.01 );
 */



/* droplet.cubicTo(size.width * 0.704, size.height, size.width * 0.852,
        size.height * 0.84, size.width * 0.852, size.height * 0.65);
    droplet.cubicTo(size.width * 0.852, size.height * 0.46, size.width * 0.521,
        size.height * 0.03, size.width * 0.507, size.height * 0.01);
    droplet.cubicTo(size.width * 0.507, size.height * 0.01, size.width * 0.5, 0,
        size.width * 0.5, 0);
    droplet.moveTo(size.width * 0.5, size.height); // first half

 */

/*
droplet.cubicTo(size.width * 0.704, size.height, size.width * 0.852,
        size.height * 0.84, size.width * (0.852 - 0.02), size.height * 0.65);
    droplet.cubicTo(
        size.width * (0.852 - 0.02),
        size.height * 0.46,
        size.width * 0.521,
        size.height * 0.03,
        size.width * 0.507,
        size.height * 0.01);
    droplet.cubicTo(size.width * 0.507, size.height * 0.01, size.width * 0.5, 0,
        size.width * 0.5, 0.0); */
    /* droplet.cubicTo(size.width * 0.296, size.height, size.width * 0.148,
        size.height * 0.84, size.width * (0.148 + 0.02), size.height * 0.65);
    droplet.cubicTo(
        size.width * (0.148 + 0.02),
        size.height * 0.46,
        size.width * 0.479,
        size.height * 0.03,
        size.width * 0.493,
        size.height * 0.01);
    droplet.cubicTo(size.width * 0.493, size.height * 0.01, size.width * 0.5, 0,
        size.width * 0.507, 0.01);
    droplet.cubicTo(size.width * 0.507, 0, size.width * 0.492,
        size.height * 0.01, size.width * 0.5, size.height * 0.0); */


/**
 
 Path droplet = Path();
    droplet.moveTo(
        size.width * 0.5, scaledSize.height + heightChange); // first half
    droplet.relativeCubicTo(
        scaledSize.width * (0.704 - 0.5),
        /* scaledSize.height, */ 0,
        scaledSize.width * (0.852 - 0.5),
        scaledSize.height * 0.84 - scaledSize.height,
        scaledSize.width * (0.852 - 0.02 - 0.5),
        scaledSize.height * 0.65 - scaledSize.height);
    droplet.relativeCubicTo(
        /* scaledSize.width * (0.852 - 0.02) */ 0,
        scaledSize.height * 0.46 - scaledSize.height * 0.65,
        scaledSize.width * (0.521 - 0.850),
        scaledSize.height * 0.03 - scaledSize.height * 0.65,
        scaledSize.width * (0.500 - 0.833),
        scaledSize.height * 0.01 - scaledSize.height * 0.65);

    /* droplet.relativeCubicTo(
        /* scaledSize.width * 0.507 */ 0,
        /* scaledSize.height * 0.01 */ 0,
        scaledSize.width * (0.5 - 0.507),
        /* 0 */ -scaledSize.height * 0.01,
        /*  scaledSize.width * 0.493 */ -scaledSize.width * 0.007,
        /* 0.01 */ /* scaledSize.height * 0.01 */ 0); */

    droplet.moveTo(size.width * 0.5, scaledSize.height + heightChange);

    droplet.relativeCubicTo(
        scaledSize.width * (0.296 - 0.5),
        /* size.height */ 0,
        scaledSize.width * (0.148 - 0.5),
        scaledSize.height * 0.84 - scaledSize.height,
        scaledSize.width * (0.148 + 0.02 - 0.5),
        scaledSize.height * 0.65 - scaledSize.height);

    droplet.relativeCubicTo(
        /* size.width * (0.148 + 0.02) */ 0,
        scaledSize.height * 0.46 - scaledSize.height * 0.65,
        scaledSize.width * (0.479 - 0.150),
        scaledSize.height * 0.03 - scaledSize.height * 0.65,
        scaledSize.width * (0.481 - 0.150),
        scaledSize.height * 0.01 - scaledSize.height * 0.65);

    /* droplet.relativeCubicTo(
        /* size.width * 0.493 */ 0,
        /* size.height * 0.01 */ 0,
        scaledSize.width * (0.5 - 0.493),
        /*  0 */ -scaledSize.height * 0.01,
        /* size.width * 0.507 */ scaledSize.width * 0.007,
        /* 0.01 */ /* scaledSize.height * 0.01 */ 0); */

    droplet.moveTo(size.width * 0.5, scaledSize.height); // first half
    Paint dropletbg = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(droplet, dropletbg);
    //// Set the radius for the circular arcs
    canvas.clipPath(droplet);
 */