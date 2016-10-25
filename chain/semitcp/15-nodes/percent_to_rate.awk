BEGIN{

}
{
    printf("%d %f\n", $1, 1.0 + $2 / 100.0)
}
END{

}
