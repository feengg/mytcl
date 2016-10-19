BEGIN{
    i = 1
}
{
    if($1==flag)
        printf("%d %g\n", i++, $2)
}
END{

}
