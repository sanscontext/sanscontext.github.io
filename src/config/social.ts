import type { SocialLink } from "../types";

export const SOCIALS: SocialLink[] = [
    {
        name: "Github",
        href: "https://github.com/sanscontext",
        linkTitle: `Laura Rubin on Github`,
        isActive: true,
    },
    {
        name: "LinkedIn",
        href: "https://linkedin.com/in/laurarubin",
        linkTitle: `Laura Rubin on LinkedIn`,
        isActive: true,
    },
    {
        name: "Mail",
        href: "mailto:rubin.laurad+inquiries@remove-this-antispam-part.gmail.com",
        linkTitle: `Send an email to Laura`,
        isActive: true,
    },
];

export const SOCIAL_ICONS: Record<string, string> = {
    Github: "Github",
    Mail: "Mail",
    Linkedin: "LinkedIn",
    "Google Scholar": "GoogleScholar",
    ORCID: "ORCID",
    RSS: "RSS",
};