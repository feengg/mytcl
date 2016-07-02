BEGIN{
    i = 1
}
{
    if ($1 == "avgSendTime:" && flag == "avgSendTime")
        printf("%d\t%.2f\n", i++, $2)
    if ($1 == "maxSendTime:" && flag == "maxSendTime")
        printf("%d\t%.2f\n", i++, $2)
    if ($1 == "minSendTime:" && flag == "minSendTime")
        printf("%d\t%.2f\n", i++, $2)
}
END{

}
